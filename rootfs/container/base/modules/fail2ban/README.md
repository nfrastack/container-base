# Container Base Addon - Fail2ban

## Purpose
Perform host based blocking to host based on analysis of log patterns

## Availability

* All OS and variants

## Configuration Files

## Environment Variables

| Parameter                | Description                                                                        | Default              | Advanced | `_FILE` |
| ------------------------ | ---------------------------------------------------------------------------------- | -------------------- | -------- | ------- |
| `FAIL2BAN_BACKEND`       | Backend                                                                            | `AUTO`               |          |         |
| `FAIL2BAN_CONFIG_PATH`   | Fail2ban Configuration Path                                                        | `/etc/fail2ban/`     |          |         |
| `FAIL2BAN_DB_FILE`       | Persistent Database File                                                           | `fail2ban.sqlite3`   |          |         |
| `FAIL2BAN_DB_PATH`       | Persistent Database Path                                                           | `/data/fail2ban/`    |          |         |
| `FAIL2BAN_DB_PURGE_AGE`  | Purge entries after how many seconds                                               | `86400`              |          |         |
| `FAIL2BAN_DB_TYPE`       | DB Type `NONE`, `MEMORY`, `FILE`                                                   | `MEMORY`             |          |         |
| `FAIL2BAN_IGNORE_IP`     | Ignore these IPs or Ranges space seperated                                         | `127.0.0.1/8`        |          |         |
|                          |                                                                                    | `::1`                |          |         |
|                          |                                                                                    | `172.16.0.0/12`      |          |         |
|                          |                                                                                    | `192.168.0.0/24`     |          |         |
| `FAIL2BAN_IGNORE_SELF`   | Ignroe Self `TRUE` `FALSE`                                                         | `TRUE`               |          |         |
| `FAIL2BAN_LOG_PATH`      | Fail2ban Log Path                                                                  | `/var/log/fail2ban/` |          |         |
| `FAIL2BAN_LOG_FILE`      | Fail2ban Log File                                                                  | `fail2ban.log`       |          |         |
| `FAIL2BAN_LOG_LEVEL`     | Log Level `CRITICAL` `ERROR` `WARNING` `NOTICE` `INFO` `DEBUG`                     | `INFO`               |          |         |
| `FAIL2BAN_LOG_TYPE`      | Log to `FILE` or `CONSOLE`                                                         | `FILE`               |          |         |
| `FAIL2BAN_MAX_RETRY`     | Max times to find pattern in log over `FAIL2BAN_TIME_FIND`                         | `5`                  |          |         |
| `FAIL2BAN_STARTUP_DELAY` | Startup Delay to give a chance for monitored logs to exist or have data in seconds | `15`                 |          |         |
| `FAIL2BAN_TIME_BAN`      | Length of time to ban in default                                                   | `10m`                |          |         |
| `FAIL2BAN_TIME_FIND`     | Window to base pattern matches against                                             | `10m`                |          |         |
| `FAIL2BAN_USE_DNS`       | Use DNS for lookups `yes` `warn` `no` `raw`                                        | `warn`               |          |         |

## Users and Groups

## Networking

## References

* https://github.com/fail2ban/fail2ban