# Container Base Addon - Tailscale

## Purpose

Allows container to join a Tailscale encrypted mesh network (VPN)

## Availability

* Alpine 3.17 and later
* Debian (all variants)

## Configuration Files

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.

| Parameter                    | Description                                 | Default               | Advanced | `_FILE` |
| ---------------------------- | ------------------------------------------- | --------------------- | -------- | ------- |
| `TAILSCALE_LISTEN_PORT`      | Port to listen on (0 = auto)                | `0`                   |          |         |
| `TAILSCALE_MODE`             | Operation mode (`DAEMON` or `CLIENT`)       | `DAEMON`              |          |         |
| `TAILSCALE_TUNNEL_INTERFACE` | Name of the tunnel network interface        | `tailscale0`          |          |         |
| `TAILSCALE_BINARY`           | Tailscale binary to execute                 | `tailscale`           | x        |         |
| `TAILSCALE_DATA_PATH`        | Path to Tailscale data directory            | `/var/lib/tailscale/` | x        |         |
| `TAILSCALE_LOG_FILE`         | Log file name                               | `tailscaled.log`      | x        |         |
| `TAILSCALE_LOG_LEVEL`        | Log verbosity level                         | `1`                   | x        |         |
| `TAILSCALE_LOG_TYPE`         | Log output type (`FILE` or other)           | `FILE`                | x        |         |
| `TAILSCALE_LOG_PATH`         | Path to Tailscale log directory             | `/var/log/tailscale/` | x        |         |
| `TAILSCALE_SETUP_MODE`       | Setup mode for Tailscale                    | `AUTO`                | x        |         |
| `TAILSCALE_SOCKET_PATH`      | Path to Tailscale socket directory          | `/var/run/tailscale/` | x        |         |
| `TAILSCALE_SOCKET_FILE`      | Tailscale socket file name                  | `tailscaled.sock`     | x        |         |
| `TAILSCALE_ENABLE_LOGTAIL`   | Enable Tailscale logtail (remote logging)   | `FALSE`               | x        |         |
| `TAILSCALE_USER`             | User to run Tailscale as                    | `root`                | x        |         |

## Users and Groups

| Type  | Name        | ID   |
| ----- | ----------- | ---- |
| User  | `tailscale` | 8245 |
| Group | `tailscale` | 8245 |

## References

* https://github.com/tailscale/tailscale
* https://tailscale.com
