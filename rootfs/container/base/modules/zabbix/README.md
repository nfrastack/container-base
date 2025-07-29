# Container Base Addon - Zabbix Agent

## Purpose

This module integrates the [Zabbix](https://www.zabbix.com/) monitoring agent into the container image to enable monitoring and management of the containerized environment. It supports both the classic Zabbix agent (`zabbix_agentd`) and the modern Zabbix agent (`zabbix_agent2`), with features such as PSK encryption, autoregistration, and custom configurations.

## Availability

* Alpine 3.5 - 3.16 - Zabbix Agent 1 (Classic)
* Alpine 3.17 and later - Zabbix Agent 2 (Modern)
* Debian (all variants)

## How It Works

### Agent Selection
The module automatically selects the appropriate Zabbix agent type (`classic` or `modern`) based on the operating system and version. Can be overidden:
- **Classic Agent (`zabbix_agentd`)**: Used for older systems or when explicitly specified.
- **Modern Agent (`zabbix_agent2`)**: Used for newer systems (e.g., Alpine 3.17+).

### Configuration Generation
The module generates a Zabbix agent configuration file based on the provided environment variables. The configuration includes:
- Logging settings
- Server and active server addresses
- PSK encryption settings (if enabled)
- Autoregistration settings (if enabled)

### PSK Encryption
If PSK encryption is enabled, the module:
- Creates a PSK file if only the key is provided.
- Configures the agent to use the PSK file for secure communication.

### Autoregistration
If autoregistration is enabled, the module:
- Adds `HostMetadata` to the configuration file for automatic registration with the Zabbix server.
- Optionally uses DNS-based autoregistration if `ZABBIX_ENABLE_AUTOREGISTER_DNS` is set to `TRUE`.

### Log Management
The module sets up log rotation for the Zabbix agent logs and ensures proper permissions for the log directory.

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.

| Parameter                            | Description                                                                                   | Default                                 | 1   | 2   | Advanced | `_FILE` |
| ------------------------------------ | --------------------------------------------------------------------------------------------- | --------------------------------------- | --- | --- | -------- | ------- |
| `ZABBIX_SETUP_TYPE`                  | Automatically generate configuration based on these variables `AUTO` or `MANUAL`              | `AUTO`                                  | x   | x   |          |         |
| `ZABBIX_AGENT_TYPE`                  | Which version of Zabbix Agent to load `1` or `2`                                              | 1                                       | N/A | N/A |          |         |
| `ZABBIX_AGENT_LOG_PATH`              | Log File Path                                                                                 | `/var/log/zabbix/agent/`                | x   | x   | x        |         |
| `ZABBIX_AGENT_LOG_FILE`              | Logfile name                                                                                  | `zabbix_agentd.log`                     | x   | x   | x        |         |
| `ZABBIX_CERT_PATH`                   | Zabbix Certificates Path                                                                      | `/etc/zabbix/certs/`                    | x   | x   |          |         |
| `ZABBIX_ENABLE_AUTOREGISTRATION`     | Use internal routine for Agent autoregistration based on config files with # Autoregister tag | `TRUE`                                  | x   | x   |          |         |
| `ZABBIX_ENABLE_AUTOREGISTRATION_DNS` | Register with DNS name instead of IP Address when autoregistering                             | `TRUE`                                  | x   | x   |          |         |
| `ZABBIX_AUTOREGISTRATION_DNS_NAME`   | (optional) DNS Name to provide for auto register. Uses `CONTAINER_NAME` as default            | `$CONTAINER_NAME`                       | x   | x   |          |         |
| `ZABBIX_AUTOREGISTRATION_DNS_SUFFIX` | If you want to append something after the generated DNS Name                                  | ``                                      | x   | x   |          |         |
| `ZABBIX_ENCRYPT_PSK_ID`              | Zabbix Encryption PSK ID                                                                      | ``                                      | x   | x   |          | x       |
| `ZABBIX_ENCRYPT_PSK_KEY`             | Zabbix Encryption PSK Key                                                                     | ``                                      | x   | x   |          | x       |
| `ZABBIX_ENCRYPT_PSK_FILE`            | Zabbix Encryption PSK File (If not using above env var)                                       | ``                                      | x   | x   |          |         |
| `ZABBIX_LOG_FILE_SIZE`               | Logfile size                                                                                  | `0`                                     | x   | x   | x        |         |
| `ZABBIX_DEBUGLEVEL`                  | Debug level                                                                                   | `1`                                     | x   | x   |          |         |
| `ZABBIX_REMOTECOMMANDS_ALLOW`        | Enable remote commands                                                                        | `*`                                     | x   | x   |          |         |
| `ZABBIX_REMOTECOMMANDS_DENY`         | Deny remote commands                                                                          | ``                                      | x   | x   |          |         |
| `ZABBIX_REMOTECOMMANDS_LOG`          | Enable remote commands Log (`0`/`1`)                                                          | `1`                                     | x   | ``  | x        |         |
| `ZABBIX_SERVER`                      | Allow connections from Zabbix server IP                                                       | `0.0.0.0/0`                             | x   | x   |          |         |
| `ZABBIX_STATUS_PORT`                 | Agent will listen to this port for status requests (http://localhost:port/status)             | `8050`                                 | ``  | x   |          |         |
| `ZABBIX_LISTEN_PORT`                 | Zabbix Agent listening port                                                                   | `10050`                                 | x   | x   |          |         |
| `ZABBIX_LISTEN_IP`                   | Zabbix Agent listening IP                                                                     | `0.0.0.0`                               | x   | x   |          |         |
| `ZABBIX_START_AGENTS`                | How many Zabbix Agents to start                                                               | `1`                                     | x   | ``  |          |         |
| `ZABBIX_SERVER_ACTIVE`               | Server for active checks                                                                      | `zabbix-proxy`                          | x   | x   |          | x       |
| `ZABBIX_HOSTNAME`                    | Container hostname to report to server                                                        | `$CONTAINER_NAME`                       | x   | x   |          |         |
| `ZABBIX_REFRESH_ACTIVE_CHECKS`       | Seconds to refresh Active Checks                                                              | `120`                                   | x   | x   | x        |         |
| `ZABBIX_BUFFER_SEND`                 | Buffer Send                                                                                   | `5`                                     | x   | x   | x        |         |
| `ZABBIX_BUFFER_SIZE`                 | Buffer Size                                                                                   | `100`                                   | x   | x   | x        |         |
| `ZABBIX_MAXLINES_SECOND`             | Max Lines Per Second                                                                          | `20`                                    | x   | ``  | x        |         |
| `ZABBIX_SOCKET`                      | Socket for communicating                                                                      | `/var/lib/zabbix/run/zabbix-agent.sock` | ``  | x   | x        |         |
| `ZABBIX_ALLOW_ROOT`                  | Allow running as root                                                                         | `1`                                     | x   | ``  |          |         |
| `ZABBIX_USER`                        | User to start agent                                                                           | `zabbix`                                | x   | x   | x        |         |
| `ZABBIX_USER_SUDO`                   | Allow Zabbix user to utilize sudo commands                                                    | `TRUE`                                  | x   | x   | x        |         |
| `ZABBIX_AGENT_TIMEOUT`               | Zabbix agent timeout (sec) for userparameter checks                                           | `3`                                     | x   | x   | x        |         |


## Users and Groups

| Type  | Name     | ID    |
| ----- | -------- | ----- |
| User  | `zabbix` | 10050 |
| Group | `zabbix` | 10050 |

## Networking

| Port    | Protocol | Description  |
| ------- | -------- | ------------ |
| `10050` | udp      | Zabbix Agent |

## References

* https://github.com/zabbix/server
* https://zabbix.com

