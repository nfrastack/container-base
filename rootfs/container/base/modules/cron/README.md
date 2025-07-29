# Container Base Addon - Cron

## Purpose
Allows for scheduling of actions to be performed using standard unix cron syntax. In this image we utilize the busybox cron variant.

## Availability

* Alpine (all variants)
* Debian (all variants)

## Configuration Files

## Environment Variables

| Parameter                     | Description                                                                    | Default     | Advanced | `_FILE` |
| ----------------------------- | ------------------------------------------------------------------------------ | ----------- | -------- | ------- |
| `CONTAINER_SCHEDULING_LOCATION` | Where to read task files            | `/assets/cron/`  |
| `SCHEDULING_LOG_TYPE`           | Log Type `FILE`                     | `FILE`           |
| `SCHEDULING_LOG_LOCATION`       | Log File Location                   | `/var/log/cron/` |
| `SCHEDULING_LOG_LEVEL`          | Log Level `1` (loud) to `8` (quiet) | `6`              |

### Cron Options

There are two ways to add jobs to be triggered via cron. One is to drop files into `/assets/cron/` which will be parsed upon container startup, or to set environment variables.

| Parameter | Description                                            | Default |
| --------- | ------------------------------------------------------ | ------- |
| `CRON_*`  | Name of the job value of the time and output to be run | ``      |

Example: `CRON_HELLO="* * * * * echo 'hello' > /tmp/hello.log`

Since you can't really disable environment variables in containers if they are baked into parent images, you can override a baked in Cron command with your own values, or to disable it entirely set the value to `FALSE` eg `CRON_HELLO=FALSE`.

## References

* https://github.com/mirror/busybox
* https://en.wikipedia.org/wiki/Cron
