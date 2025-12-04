# nfrastack/container-base

## About

This repository provides a modular container base image designed to accelerate the creation of downstream application containers. It includes a suite of commonly required features and modules, enabling rapid development and customization for a wide range of use cases.

* Supporting [Alpine Linux](https://www.alpinelinux.org) 3.5-3.23
* Supporting [Debian Linux](https://www.debian.org) Trixie, Bookworm, Bullseye, Buster
* Multi Processes - Utilize an initialization system to self contain entire application within the image.
* User Management - Update User ID and Group ID permissions dynamically
* Messaging - Send messages from within container
* Monitoring - Track application and container metrics
* Logging - Allow for logrotation, or shipping to centralized log collector
* Scheduling - Execute tasks at specific times
* Secrets Management - Inject secrets or grab from central repository during runtime
* Firewalling - Block or allow remote hosts based on patterns
* VPN - Run VPN clients within the container
* and many customizable settings.

## Maintainer

- [Nfrastack](https://www.nfrastack.com)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Installation](#installation)
  - [Prebuilt Images](#prebuilt-images)
  - [Multi-Architecture Support](#multi-architecture-support)
  - [Build from Source](#build-from-source)
- [Configuration](#configuration)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Container Options](#container-options)
    - [Container Logging Options](#container-logging-options)
    - [Container Process Watchdog Options](#container-process-watchdog-options)
    - [Modules Options](#modules-options)
    - [Networking Lookup Override Options](#networking-lookup-override-options)
    - [Script Override Options](#script-override-options)
    - [Permissions Options](#permissions-options)
- [Developing / Overriding](#developing--overriding)
- [Debug Mode](#debug-mode)
- [Shell Access](#shell-access)
- [Support & Maintenance](#support--maintenance)
- [License](#license)

## Installation

### Prebuilt Images
Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-base/pkgs/container/container-base)
To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

```
(container platform) pull ghcr.io/nfrastack/container-base:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>-<distribution>_<distribution_release>_<optional_features>`

Example:

`ghcr.io/nfrastack-container-base:1.0-alpine_3.22_core` or

`ghcr.io/nfrastack-container-base:alpine_3.22` or

`ghcr.io/nfrastack-container-base:debian_trixie`

* An optional tag may exist that matches the [CHANGELOG](CHANGELOG.md)
* Distribution can either be `alpine` or `debian`
* Disribution release varies - see the registry for availability
* Features
  * `core` - Includes `age`, `cron`, `logrotate`, `s6overlay`, `msmtp`
  * `faflopza` - Includes everything in core and `fail2ban`, `fluentbit`, `openbao`, `zabbix` - *This is the default image if no features requested*
  * `faflopzaze` Includes everything in `faflopza` and `zerotier`.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Build from Source

Clone this repository and build the image with your preferred container builder. Customize modules as needed—see the [MODULES documentation](/rootfs/container/base/modules) for details. Building the image from source enables all advanced functionality.

## Configuration

### Persistent Storage

The following directories are used for configuration and can be optionally mapped for persistent storage.

| Directory  | Description                              |
| ---------- | ---------------------------------------- |
| `/var/log` | Container, Cron, Zabbix, other log files |

TODO: Add overrides and custom-script info

### Environment Variables

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### Container Options

| Parameter        | Description                                             | Default    | Advanced |
| ---------------- | ------------------------------------------------------- | ---------- | -------- |
| `CONTAINER_NAME` | Used for setting entries in Monitoring and Log Shipping | (hostname) |          |
| `TIMEZONE`       | Set Timezone                                            | `Etc/GMT`  |          |

#### Container Logging Options

| Parameter                             | Description                                                               | Default                            | Advanced |
| ------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------- | -------- |
| `CONTAINER_COLORIZE_OUTPUT`           | Enable/Disable colorized console output                                   | `TRUE`                             |          |
| `CONTAINER_ENABLE_CUSTOM_BASH_PROMPT` | TODO Set a different bash prompt then '(imagename):(version) HH:MM:SS # ' |                                    | x        |
| `CONTAINER_ENABLE_LOG_TIMESTAMP`      | Prefix this images container logs with timestamp                          | `TRUE`                             |          |
| `CONTAINER_LOG_LEVEL`                 | Control level of output of container `INFO`, `WARN`, `NOTICE`, `DEBUG`    | `NOTICE`                           |          |
| `CONTAINER_LOG_PREFIX_TIME_FMT`       | Timestamp Time Format                                                     | `%H:%M:%S`                         |          |
| `CONTAINER_LOG_PREFIX_DATE_FMT`       | Timestamp Date Format                                                     | `%Y-%m-%d`                         |          |
| `CONTAINER_LOG_PREFIX_SEPERATOR`      | Timestamp seperator                                                       | `-`                                |          |
| `CONTAINER_LOG_FILE_LEVEL`            | Control level of output of container `INFO`, `WARN`, `NOTICE`, `DEBUG`    | `DEBUG`                            | x        |
| `CONTAINER_LOG_FILE_NAME`             | Internal Container Logs filename                                          | `/var/log/container/container.log` | x        |
| `CONTAINER_LOG_FILE_PATH`             | Path where to find the internal container logs                            | `/var/log/container/`              | x        |
| `CONTAINER_LOG_FILE_PREFIX_TIME_FMT`  | Timestamp Time Format                                                     | `%H:%M:%S`                         | x        |
| `CONTAINER_LOG_FILE_PREFIX_DATE_FMT`  | Timestamp Date Format                                                     | `%Y-%m-%d`                         | x        |
| `CONTAINER_LOG_FILE_PREFIX_SEPERATOR` | Timestamp seperator                                                       | `-`                                | x        |

#### Container Process Watchdog Options

This functionality is an attempt to avoid problems within the container that can "run away" from being executed too often.

Sample use cases:

* Alert slack channel when process has executed more than once
* Disable process from executing further if restarted 50 times
* Write to an additional log file..
* Change a file to display "Under Maintenance" on a webserver if this process isn't supposed to be run more than 1 time.

It will pass 5 arguments to a bash script titled the same name as the executing script or if not found, use the default `CONTAINER_PROCESS_HELPER_SCRIPT` below. Drop your files into the `CONTAINER_PROCESS_HELPER_PATH`.

For example, if `04-scheduling` was starting, it would look for `$CONTAINER_PROCESS_HELPER_PATH/04-scheduling` and if found execute it while passing the following arguments: DATE,TIME,SCRIPT_NAME,TIMES EXECUTED,HOSTNAME

e.g: `2025-07-01 23:01:04 04-scheduling 2 container`

Use the values in your own bash script using the `$1` `$2` `$3` `$4` `$5` syntax.
Change time and date and settings with these environment variables

| Parameter                                     | Description                                                     | Default                     | Advanced |
| --------------------------------------------- | --------------------------------------------------------------- | --------------------------- | -------- |
| `CONTAINER_ENABLE_PROCESS_COUNTER`            | Show how many times process has executed in console log         | `TRUE`                      | x        |
| `CONTAINER_ENABLE_PROCESS_HELPER`             |                                                                 | `TRUE`                      | x        |
| `CONTAINER_PROCESS_HELPER_PATH`               | Path to file external helper scripts                            | `/container/processhelper/` | x        |
| `CONTAINER_PROCESS_HELPER_SCRIPT`             | Default helper script name                                      | `processhelper.sh`          | x        |
| `CONTAINER_PROCESS_HELPER_DATE_FMT`           | Date format passed to external script                           | `%Y-%m-%d`                  | x        |
| `CONTAINER_PROCESS_HELPER_TIME_FMT`           | Time format passed to external script                           | `%H:%M:%S`                  | x        |
| `CONTAINER_PROCESS_RUNAWAY_PROTECTOR`         | Disables a service if executed more than (x) amount of times    | `TRUE`                      | x        |
| `CONTAINER_PROCESS_RUNAWAY_DELAY`             | Delay in seconds to restart process                             | `1`                         | x        |
| `CONTAINER_PROCESS_RUNAWAY_LIMIT`             | The amount of times it needs to restart before disabling        | `10`                        | x        |
| `CONTAINER_PROCESS_RUNAWAY_SHOW_OUTPUT_FINAL` | Show the program Output on the final execution before disabling | `TRUE`                      | x        |

#### Modules Options

Only valid if appropriate module has been installed within the image. See [MODULES documentation](/rootfs/container/base/modules) for more information to see other configurable options.

| Parameter                       | Description                                  | Default      | Advanced |
| ------------------------------- | -------------------------------------------- | ------------ | -------- |
| `CONTAINER_ENABLE_METRICS`      | Enable Metrics                               | `TRUE`       | x        |
| `CONTAINER_ENABLE_MONITORING`   | Enable Monitoring of applications or metrics | `TRUE`       |          |
| `CONTAINR_MONITORING_BACKEND`   | What monitoring agent to use `zabbix`        | `zabbix`     |          |
| `CONTAINER_ENABLE_MESSAGING`    | Enable Messaging services like SMTP          | `TRUE`       |          |
| `CONTAINER_MESSAGING_BACKEND`   | Messaging Backend - presently only `msmtp`   | `msmtp`      |          |
| `CONTAINER_ENABLE_SCHEDULING`   | Enable Scheduled Tasks                       | `TRUE`       |          |
| `CONTAINR_SCHEDULING_BACKEND`   | What scheduling tool to use `cron`           | `cron`       |          |
| `CONTAINER_ENABLE_LOGROTATE`    | Enable Logrotate (if scheduling enabled)     | `TRUE`       |          |
| `CONTAINER_ENABLE_LOGSHIPPING`  | Enable Log Shipping                          | `FALSE`      |          |
| `CONTAINER_LOGSHIPPING_BACKEND` | Log shipping backend `fluent-bit`            | `fluent-bit` |          |
| `CONTAINER_ENABLE_FIREWALL`     | Enable Firewall Functionality                | `FALSE`      |          |
| `CONTAINER_FIREWALL_BACKEND`    | What Firewall backend to use `iptables`      | `iptables`   |          |

#### Networking Options
##### Firewall Options

Included when proper capabilities are set on image is the capability to set up detailed block / allow rules via a firewall on container start.
Presently only `iptables` is supported.
You must use run your containers with the following capabilities added: `NET_ADMIN`, `NET_RAW`

| Parameter                    | Description                             | Default    |
| ---------------------------- | --------------------------------------- | ---------- |
| `CONTAINER_ENABLE_FIREWALL`  | Enable Firewall Functionality           | `FALSE`    |
| `CONTAINER_FIREWALL_BACKEND` | What Firewall backend to use `iptables` | `iptables` |
| `FIREWALL_RULE_00`           | Firewall rule to execute                |            |
| `FIREWALL_RULE_01`           | Next firewall rule to execute           |            |

One can use the `FIREWALL_RULE_XX` environment variables to pass rules to the firewall. In this example I am going to block someone from being able to access a port except if from a specific IP address:

```bash
FIREWALL_RULE_00=-I INPUT -p tcp -m tcp -s 101.69.69.101 --dport 389 -j ACCEPT
FIREWALL_RULE_01=-I INPUT -p tcp -m tcp -s 0.0.0.0/0 --dport 389 -j DROP
```

###### IPTables Options

Instead of relying on environment variables one can put a `iptables-restore` compatible ruleset below and it will be imported on container start.

| Parameter             | Description                                                 | Default                |
| --------------------- | ----------------------------------------------------------- | ---------------------- |
| `IPTABLES_RULES_PATH` | Path for IPTables Rules                                     | `/contianer/iptables/` |
| `IPTABLES_RULES_FILE` | IPTables Rules File to restore if exists on container start | `iptables.rules`       |

##### Networking Lookup Override Options

Sometimes you may need to add aliases or change the response of DNS lookups.. This will add an entry to the containers hosts file.

| Parameter                    | Description               |
| ---------------------------- | ------------------------- |
| `CONTAINER_HOST_OVERRIDE_01` | Create manual hosts entry |

Make the value `<destination> override1 override2` eg `1.2.3.4 example.org example.com`.
If you omit an IP Address and instead use a domain name it will attempt to look it up to an IP eg `proxy example.com example.org`

#### Script Override Options

This image can execute commands or scripts after the container initializes so that you can perform commands without having to rebuild the entire image or maintain a new codebase. Simply pass the command you wish to execute, or execute a script from the location from a mapped volume.

| Parameter                                      | Description                                                                                     | Default                    | Advanced |
| ---------------------------------------------- | ----------------------------------------------------------------------------------------------- | -------------------------- | -------- |
| `CONTAINER_CUSTOM_PATH`                        | Used for adding custom files into the image upon startup                                        | `/override/custom`         | x        |
| `CONTAINER_CUSTOM_SCRIPTS_PATH`                | Used for adding custom scripts to execute upon startup                                          | `/override/custom-scripts` | x        |
| `CONTAINER_INIT_PRE_COMMAND_<SCRIPTNAME>`      | If you wish to execute a command in the container before the service has initialized            |                            |          |
|                                                | enter it here, eg `CONTAINER_INIT_PRE_COMMAND_NGINX=echo 'pre nfrastack'`. If you pass a        |                            |          |
|                                                | filename as value , it will execute the file                                                    |                            |          |
| `CONTAINER_INIT_POST_COMMAND_<SCRIPTNAME>`     | If you wish to execute a command in the container after the service has initialized             |                            |          |
|                                                | enter it here, eg `CONTAINER_INIT_POST_COMMAND_NGINX=echo 'post nfrastack'`. If you pass a      |                            |          |
|                                                | filename as value , it will execute the file                                                    |                            |          |
| `CONTAINER_INIT_PRE_COMMAND`                   | If you wish to execute a command in the container before all services have initialized          |                            |          |
|                                                | enter it here.                                                                                  |                            |          |
| `CONTAINER_INIT_POST_COMMAND`                  | If you wish to execute a command in the container after all services have initialized           |                            |          |
|                                                | enter it here.                                                                                  |                            |          |
| `CONTAINER_SHUTDOWN_PRE_COMMAND`               | If you wish to execute a command in the container before the shutdown sequence starts           |                            |          |
|                                                | enter it here.                                                                                  |                            |          |
| `CONTAINER_SHUTDOWN_POST_COMMAND`              | If you wish to execute a command in the container after the shutdown sequence has completed     |                            |          |
|                                                | enter it here.                                                                                  |                            |          |
| `CONTAINER_SHUTDOWN_PRE_COMMAND_<SCRIPTNAME>`  | If you wish to execute a command in the container before the shutdown routines have initialized |                            |          |
|                                                | enter it here, eg `CONTAINER_SHUTDOWN_PRE_COMMAND_NGINX=echo 'pre nfrastack'`. If you pass a    |                            |          |
|                                                | filename as value , it will execute the file                                                    |                            |          |
| `CONTAINER_SHUTDOWN_POST_COMMAND_<SCRIPTNAME>` | If you wish to execute a command in the container after the shutdown routines have completed    |                            |          |
|                                                | enter it here, eg `CONTAINER_SHUTDOWN_POST_COMMAND_NGINX=echo 'post nfrastack'`. If you pass a  |                            |          |
|                                                | filename as value , it will execute the file                                                    |                            |          |


#### Permissions Options

If you wish to change the internal id for users and groups you can set environment variables to do so.
e.g. If you add `USER_NGINX=1000` it will reset the containers `nginx` user id from `82` to `1000` -

If you enable `DEBUG_PERMISSIONS=TRUE` all the users and groups have been modified in accordance with
environment variables will be displayed in output.

Hint, also change the Group ID to your local development users UID & GID and avoid Docker permission issues when developing.

| Parameter                         | Description                                                                 |
| --------------------------------- | --------------------------------------------------------------------------- |
| `CONTAINER_USER_<USERNAME>`       | The user's UID in /etc/passwd will be modified with new UID                 |
| `CONTAINER_GROUP_<GROUPNAME>`     | The group's GID in /etc/group and /etc/passwd will be modified with new GID |
| `CONTAINER_GROUP_ADD_<GROUPNAME>` | The username will be added in /etc/group after the group name defined       |

## Developing / Overriding

This base image has been used over a hundred times to successfully build secondary images. My methodology is admittedly straying from the "one process per container" rule, however this methodology allows me to put together images at a rapid pace, and if more complex scalability is required, the work is split into their own individual images. Since you are reading this here's a crash course at how the image works - (WIP):

See `/container/base/functions/` for more detailed documentation for the various commands and functions/shortcuts

- Put defaults in `/container/defaults/(script name)`
- Put functions in `/container/functions/(script name)`
- Put Initialization script in `container/init/init.d/(script name)`
-
  Put at the top:

````bash
#!/command/with-contenv bash                            # Pull in Container Environment Variables from Containerfile/Container Runtime

source /container/base/functions/container/init         # Pull in all custom container functions from this image
prepare_service single                                  # Read functions and defaults only from files matching this script filename - see detailed docs for more
SERVICE_NAME="nginx"                                    # set the prefix for any logging

.. your scripting ..
print_info "This an INFO log"
print_warn "This a WARN log"
print_error "This is a ERROR log"

liftoff                                                 # this writes to the state files at /container/state/.container/ to prove the script executed properly
````

Once initialization has completed, it will then execute a service script.

- Put the services script in `/container/run/available/(script_name)/run`

  Put at the top:

````bash
#!/command/with-contenv bash                            # Pull in Container Environment Variables from Containerfile/Container Runtime

source /container/base/functions/container/init         # Pull in all custom container functions from this image
SERVICE_NAME="nginx"                                    # set the prefix for any logging

check_container_initialized                             # Check to make sure that the container properly initialized before proceeding
check_service_initialized init                          # Check to see if the init/(script name) executed correctly, otherwise wait until it has done
liftoff                                                 # Prove script was able to execute properly

print_start "Starting processname"                      # Show STARTING log prefix, and also show if enabled a counter, and execute process watchdog script
fakeprocess (args)                                      # whatever your process you want to start is
````

| Parameter                     | Description                                                                          | Default     |
| ----------------------------- | ------------------------------------------------------------------------------------ | ----------- |
| `CONTAINER_SKIP_SANITY_CHECK` | Skip the checking to see if all scripts in /container/init/init.d executed correctly | `FALSE`     |
| `DEBUG_MODE`                  | Show all script output (set -x)                                                      | `FALSE`     |
| `SERVICE_NAME`                | Used for prefixing the script that is running                                        | `container` |

## Debug Mode

When using this as a base image, create statements in your startup scripts to check for existence of `DEBUG_MODE=TRUE`
and set various parameters in your applications to output more detail, enable debugging modes, and so on.
In this base image it does the following:

* Shows all script output (equivalent to set -x)

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.

## Support & Maintenance

- For community help, tips, and community discussions, visit the [Discussions board](../../discussions).
- For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
- To report bugs, submit a [Bug Report](issues/new). Usage questions may be closed as not-a-bug.
- Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
- Updates are best-effort, with priority given to active production use and support agreements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
