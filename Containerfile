# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    DISTRO \
    DISTRO_VARIANT

FROM docker.io/${DISTRO}:${DISTRO_VARIANT}

LABEL \
        org.opencontainers.image.title="Base" \
        org.opencontainers.image.description="Container Base Image" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/base" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/container-base/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/container-base.git" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"

ARG     \
        IMAGE_BASE_MODULES="+cron,+logrotate,+msmtp,+s6overlay," \
        IMAGE_MODULES \
        IMAGE_NAME \
        IMAGE_BASE_VERSION \
        IMAGE_BASE_REPO_URL \
        TIMEZONE=Etc/GMT \
        AGE_VERSION \
        FLUENTBIT_VERSION \
        INFISICAL_VERION \
        OPENBAO_VERSION \
        S6_OVERLAY_VERSION \
        TAILSCALE_VERSION \
        ZEROTIER_VERSION \
        ZABBIX_VERSION

ENV     \
        PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/command \
        S6_KEEP_ENV=1 \
        IMAGE_NAME="nfrastack/base" \
        IMAGE_REPO_URL="https://github.com/nfrastack/container-base/"

COPY    CHANGELOG.md    /usr/src/build_image/CHANGELOG.md
COPY    LICENSE         /usr/src/build_image/LICENSE
COPY    README.md       /usr/src/build_image/README.md
COPY    rootfs/         /

RUN case "$(grep -o '^ID=.*' /etc/os-release | cut -d = -f2)" in \
        alpine ) \
            apk update ; \
            apk add -t .nfrastack-needed_do_not_remove bash ; \
        ;; \
    esac

SHELL ["/bin/bash", "-c"]

RUN echo "" && \
    source /container/base/functions/container/build && \
    case "$(container_info distro)" in \
        alpine ) \
            if [ "$(grep -o '^PRETTY_NAME=.*' /etc/os-release | cut -d = -f2)" = '"Alpine Linux edge"' ] ; then \
                apk add merge-usr ; \
                merge-usr ; \
            fi ; \
            case "$(container_info variant)" in \
                3.[5-9] | 3.1[1-6] ) \
                    alpine_ssl=libressl ; \
                ;; \
                3.1[7-9] | 3.2[0-9] ) \
                    alpine_ssl=openssl ; \
                ;; \
            esac ; \
            \
            case "$(container_info variant)" in \
                3.[5-8] ) \
                    zstd_pacakge="" ; \
                ;; \
                *) \
                    zstd_package="zstd" ; \
                ;; \
            esac ; \
            \
            IMAGE_BASE_BUILD_DEPS_ALPINE=" \
                                            gettext \
                                            musl-dev \
                                         " \
                                         ; \
            IMAGE_BASE_RUN_DEPS_ALPINE=" \
                                            acl \
                                            ${alpine_ssl} \
                                            bash \
                                            ${busybox_extras} \
                                            ca-certificates \
                                            curl \
                                            git \
                                            grep \
                                            libgcc \
                                            $(apk search libssl1* -q) \
                                            nano \
                                            sudo \
                                            tzdata \
                                            xz \
                                            ${zstd_package} \
                                       " \
                                       ; \
        ;; \
        debian ) \
            \
            IMAGE_BASE_BUILD_DEPS_DEBIAN=" \
                                            \
                                        " \
                                        ; \
            IMAGE_BASE_RUN_DEPS_DEBIAN=" \
                                            acl \
                                            apt-transport-https \
                                            apt-utils \
                                            aptitude \
                                            busybox-static \
                                            ca-certificates \
                                            curl \
                                            dirmngr \
                                            gettext \
                                            git \
                                            gnupg \
                                            nano \
                                            procps \
                                            sudo \
                                            tar \
                                            tzdata \
                                            zstd \
                                       " \
                                       ; \
        ;; \
    esac ; \
    \
    package update && \
    package upgrade && \
    package install \
                    IMAGE_BASE_BUILD_DEPS \
                    IMAGE_BASE_RUN_DEPS \
                    && \
    \
    mkdir -p \
            /etc/bash/ \
            /run/secrets \
            /usr/local/bin \
            /usr/local/sbin \
            && \
    \
    if [ -e "/usr/bin/envsubst" ] ; then mv /usr/bin/envsubst /usr/local/bin/envsubst ; fi && \
    container_build_log base && \
    rm -rf /etc/timezone && \
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    case "$(container_info distro)" in \
        "debian" ) \
            dpkg-reconfigure -f noninteractive tzdata ; \
            rm -rf \
                /usr/bin/crontab \
                /usr/sbin/cron \
                ; \
            \
            busybox --install -s /usr/bin ; \
        ;; \
    esac ; \
    \
    _container_modules_parse IMAGE_BASE_MODULES && \
    _container_modules_parse IMAGE_MODULES && \
    package remove IMAGE_BASE_BUILD_DEPS && \
    package cleanup && \
    \
    rm -rf \
            /etc/*.apk.new \
            /etc/cron* \
            /etc/issue \
            /etc/periodic/{*,.??*} \
            /etc/profile.d/{*,.??*} \
            /media \
            /usr/share/gnome/help/*/{*,.??*} \
            /usr/share/info/{*,.??*} \
            /usr/share/linda/{*,.??*} \
            /usr/share/lintian/overrides/{*,.??*} \
            /usr/share/omf/*/*-*.emf

ENTRYPOINT ["/init"]
