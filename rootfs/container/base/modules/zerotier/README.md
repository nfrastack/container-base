# Container Base Addon - ZeroTier

## Purpose

Allows container to join a ZeroTier encrypted mesh network (VPN)

## Availability

* Alpine 3.17 and later
* Debian (all variants)

## Configuration Files

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.

| Parameter                           | Description                        | Default                  | Advanced | `_FILE` |
| ----------------------------------- | ---------------------------------- | ------------------------ | -------- | ------- |
| `ZEROTIER_NETWORK`                  | ZeroTier Network to Join           |                          |          | x       |
| `ZEROTIER_IDENTITY_PUBLIC`          | Zerotier Public Identity           |                          |          | x       |
| `ZEROTIER_IDENTITY_PRIVATE`         | ZeroTier Private Identity          |                          |          | x       |
| `ZEROTIER_BINARY`                   | ZeroTier binary to execute         | `zerotier-one`           | x        |         |
| `ZEROTIER_DATA_PATH`                | Path to ZeroTier data directory    | `/var/lib/zerotier-one/` | x        |         |
| `ZEROTIER_ENABLE_METRICS`           | Enable ZeroTier metrics collection | `FALSE`                  | x        |         |
| `ZEROTIER_GROUP`                    | Group to run ZeroTier as           | `root`                   | x        |         |
| `ZEROTIER_LOG_FILE`                 | Log file name                      | `zerotier.log`           | x        |         |
| `ZEROTIER_LOG_PATH`                 | Path to ZeroTier log directory     | `/var/log/zerotier/`     | x        |         |
| `ZEROTIER_LOG_TYPE`                 | Log output type (`FILE` or other)  | `FILE`                   | x        |         |
| `ZEROTIER_USER`                     | User to run ZeroTier as            | `root`                   | x        |         |
| `ZEROTIER_LISTEN_PORT`              | Zerotier communication port        | `9993`                   |          |         |
| `ZEROTIER_ENABLE_PORT_MAPPING`      | Enable Port Mapping                | `TRUE`                   |          |         |
| `ZEROTIER_ALLOW_TCP_FALLBACK_RELAY` | Enable Fallback Relay              | `TRUE`                   |          |         |

## Users and Groups

| Type  | Name       | ID   |
| ----- | ---------- | ---- |
| User  | `zerotier` | 9376 |
| Group | `zerotier` | 9376 |

## Networking

## References

* https://github.com/zerotier/zerotierone
* https://zerotier.com