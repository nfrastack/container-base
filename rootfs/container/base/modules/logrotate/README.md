# Container Base Addon - Logrotate

## Purpose

Allows the ability for logs to be automatically rotated on a daily basis and compressed.

# Configuration Files

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.
*
| Parameter                     | Description                                                                    | Default     | Advanced | `_FILE` |
| ----------------------------- | ------------------------------------------------------------------------------ | ----------- | -------- | ------- |
| `LOGROTATE_COMPRESSION_TYPE`             | Logfile compression algorithm `NONE` `BZIP2` `GZIP` `ZSTD`  | `ZSTD`       |
| `LOGROTATE_COMPRESSION_VALUE`            | What level of compression to use                            | `8`          |
| `LOGROTATE_COMPRESSION_EXTRA_PARAMETERS` | Pass extra parameters to the compression command (optional) |              |
| `LOGROTATE_RETAIN_DAYS`                  | Rotate and retain logs for x days                           | `7`          |

## References

* https://github.com/logrotate/logrotate
