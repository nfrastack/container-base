## 2026.7.0beta 2026-07-01 <code at nfrastack dot com>

   ### Changed
      - Fix not parsing cron advanced
      
## 2026.6.0 2026-06-09 <code at nfrastack dot com>

   ### Added
      - Zabbix Agent 7.4.11
      - Fluent-Bit 5.0.7

   ### Changed
      - Cleaup temp information when clone_git_repo edge cases occur


## 2026.5.8 2026-05-28 <code at nfrastack dot com>

   ### Changed
      - Properly cleanup buildtime binaries introduced in > 2026.5.6
      - Tailscale 1.98.3 module


## 2026.5.7 2026-05-27 <code at nfrastack dot com>

   ### Changed
      - Change package build to be runtime always to not introduce breaking changes


## 2026.5.6 2026-05-27 <code at nfrastack dot com>

   ### Changed
      - Changes to package function - fix build node routine
      - Add runtime argument to persist output for use in running container
      - Optimize cleanup function


## 2026.5.5 2026-05-26 <code at nfrastack dot com>

   ### Changed
      - Fix parsing CONTAINER_(INIT|SHUTDOWN)_(PRE|POST)_COMMAND_${command_name} to allow for originally documented UPPERCASE key name


## 2026.5.4 2026-05-13 <code at nfrastack dot com>

   ### Added
      - Support wildcards for transform_var env

   ### Changed
      - Fix bracketed [env:VAR] tokens when text follows closing bracket in transform_var env


## 2026.5.3 2026-05-11 <code at nfrastack dot com>

   ### Added
      - S6 Overlay 3.2.3.0

   ### Changed
      - Add dereferencing for update_template


## 2026.5.2 2026-05-08 <code at nfrastack dot com>

   ### Added
      - transform_var file supports wildcards


## 2026.5.1 2026-05-07 <code at nfrastack dot com>

   ### Added
      - Tailscale 1.98.1
      - Fluent-bit 5.0.5

   ### Changed
      - Workaround kernel freature with write_file not wanting to write to files created with mktemp


## 2026.5.0 2026-05-07 <code at nfrastack dot com>

   ### Added
      - Fluent-bit 5.0.4
      - Tailscale 1.98.0
      - Zabbix Agent 7.4.10

   ### Changed
      - Quiet down some package output
      - Add Age to < Alpine 3.17 releases to support secret decryption


## 2026.4.0 2026-04-20 <code at nfastack dot com>

   ### Added
      - Fluent-bit 5.0.3
      - OpenBao 2.5.3

   ### Changed
      - Alter prepare_service to appropriately pull in runtime_env
      - write_file function now can set user:group@file:755 style syntaxes


## 2026.3.3 2026-03-31 <code at nfastack dot com>

   ### Added
      - Fluent-bit 5.0.1

   ### Changed
      - Further clone_git_repo fixes with tty detection
      - Logging edge case with downstream images


## 2026.3.2 2026-03-29 <code at nfastack dot com>

   ### Added
      - OpenBao 2.5.2

   ### Changed
      - Fix clone_git_repo function noise in build.log introduced in 2026.3.1


## 2026.3.1 2026-03-14 <code at nfastack dot com>

   ### Added
      - Zabbix 7.4.8

   ### Changed
      - Speedup clone_git_repo function
      - Performance optimizations
      - Environment variable parsing upgrades when weird edge cases arise down-down-down stream


## 2026.3.0 2026-03-09 <code at nfastack dot com>

   ### Added
      - OpenBAO 2.5.1
      - Add package build functions for Ruby and Python
      - Allow version override for go/yq


## 2026.02.3 2026-02-22 <code at nfastack dot com>

   ### Changed
      - Update env parsing routines to support lowercase and uppercase


## 2026.02.2 2026-02-20 <code at nfastack dot com>

   ### Changed
      - Fix init routines when CONTAINER_LOG_LEVEL=DEBUG set


## 2026.02.1 2026-02-20 <code at nfastack dot com>

   ### Added
      - write_file function
      - container runtime environment building and parsing
      - shell container buildtime environment parsing


## 2026.2.0 2026-02-19 <code at nfastack dot com>

   ### Added
      - render_template function
      - build_env function
      - transform_var env function
      - OpenBao 2.5.0
      - Zabbix Agent 7.4.7
      - Tailscale 1.94.2
      - Fluent-Bit 4.2.3


## 2026.1.0 2026-01-25 <code at nfastack dot com>

   ### Changed
      - Age 1.3.1
      - Zabbix Monitoring configuration cleanup
      - Tailscale 1.92.5
      - Changed redirections to use tee
      - S6 Overlay 3.2.2.0


## 2025.12.1 2025-12-31 <code at nfastack dot com>

   ### Changed
      - Package cleanup not removing all symbolic links
      - Binary Check for Logshipping not working due to hyphens
      - Fluent-bit module not executing properly
      - Add ca-certificates for alpine variant
      - Properly output Zabbix Agent versions
      - Fluent-bit 4.2.2
      - Age 1.3.0
      - Zerotier 1.16.1


## 2025.12.0 2025-12-19 <code at nfrastack dot com>

   - Initial Tagged release
   - Alpine 3.5 -> 3.24 support
   - Debian Bookworm and Trixie Support

