# Container Base Addon - Fluent-Bit

## Purpose
Use this module to ship logs from the container to a centralize log collection service

## Availability

* Alpine 3.14 and later
* Debian (all variants)

## How It Works

**Log Collection**:
- Fluent Bit collects logs from specified sources (e.g., files, using input plugins.
- The input plugin is configured via the `FLUENTBIT_INPUT` environment variable.

**Log Processing**:
- Logs are filtered, parsed, or enriched using Fluent Bit's filtering capabilities.
- Filters can be defined in the Fluent Bit configuration file.

**Log Shipping**:
- Processed logs are shipped to the specified destination using output plugins.
- The output plugin is configured via the `FLUENTBIT_OUTPUT` environment variable.

### Log Shipping Parsing

You can set an environment variable to start shipping a log without any other configuration. Create a variable starting with `LOGSHIP_<name>` with the value of the location of the log files. You can also use this to null an existing configuration by setting the value of `FALSE`.

Example: `LOGSHIP_NGINX=/var/log/nginx/*.log` will create and tag all log files from that directory as to be coming from `CONTAINER_NAME` and from `nginx`. Note, it does not allow for custom parsing, so will simply parse the log entry as is.

If `LOGSHIPPING_AUTO_CONFIG_LOGROTATE` set to true, you can define what parser the configuration file should use. Make sure you have the appropriate `.conf` parsers in `/etc/fluent-bit/parsers.d/`
Create a line in the `logrotate.d/<file>` that looks like `# logship: <parser>`. Multiple parsers can be added by seperating via commas. Alternatively, if you wanted to skip a certain logfile from being parsed by the log shipper, use the value "SKIP".

| Parameter                           | Description                                                                          | Default |
| ----------------------------------- | ------------------------------------------------------------------------------------ | ------- |
| `LOGSHIPPING_AUTO_CONFIG_LOGROTATE` | Automatically configure log shipping for files that are listed in `/etc/logrotate.d` | `TRUE`  |

## Configuration Files

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.

| Parameter                             | Description                                                                                      | Default                  | Advanced | `_FILE` |
| ------------------------------------- | ------------------------------------------------------------------------------------------------ | ------------------------ | -------- | ------- |
| `FLUENTBIT_CONFIG_PARSERS`            | Parsers config file name                                                                         | `parsers.conf`           | x        |         |
| `FLUENTBIT_CONFIG_PLUGINS`            | Plugins config file name                                                                         | `plugins.conf`           | x        |         |
| `FLUENTBIT_ENABLE_HTTP_SERVER`        | Embedded HTTP Server for metrics `TRUE` / `FALSE`                                                | `TRUE`                   |          |         |
| `FLUENTBIT_ENABLE_STORAGE_METRICS`    | Public storage pipeline metrics in /api/v1/storage                                               | `TRUE`                   |          |         |
| `FLUENTBIT_FLUSH_SECONDS`             | Wait time to flush records in seconds                                                            | `1`                      | x        |         |
| `FLUENTBIT_FORWARD_BUFFER_CHUNK_SIZE` | Buffer Chunk Size                                                                                | `32KB`                   | x        |         |
| `FLUENTBIT_FORWARD_BUFFER_MAX_SIZE`   | Buffer Maximum Size                                                                              | `64KB`                   | x        |         |
| `FLUENTBIT_FORWARD_PORT`              | What port when using `PROXY` (listen) mode or `FORWARD` (client) output                          | `24224`                  |          |         |
| `FLUENTBIT_GRACE_SECONDS`             | Wait time before exit in seconds                                                                 | `1`                      | x        |         |
| `FLUENTBIT_HTTP_LISTEN_IP`            | HTTP Listen IP                                                                                   | `0.0.0.0`                |          |         |
| `FLUENTBIT_HTTP_LISTEN_PORT`          | HTTP Listening Port                                                                              | `2020`                   |          |         |
| `FLUENTBIT_LOG_FILE`                  | Log File                                                                                         | `fluentbit.log`          | x        |         |
| `FLUENTBIT_LOG_LEVEL`                 | Log Level `info` `warn` `error` `debug` `trace`                                                  | `info`                   | x        |         |
| `FLUENTBIT_LOG_PATH`                  | Log Path                                                                                         | `/var/log/fluentbit/`    | x        |         |
| `FLUENTBIT_MODE`                      | Type of operation - Client `NORMAL` or Proxy `PROXY`                                             | `NORMAL`                 |          |         |
| `FLUENTBIT_OUTPUT_FORWARD_HOST`       | Where to forward Fluent-Bit data to                                                              | `fluent-proxy`           |          | x       |
| `FLUENTBIT_OUTPUT_FORWARD_TLS_VERIFY` | Verify certificates when using TLS                                                               | `FALSE`                  |          |         |
| `FLUENTBIT_OUTPUT_FORWARD_TLS`        | Enable TLS when forwading                                                                        | `FALSE`                  |          |         |
| `FLUENTBIT_OUTPUT_LOKI_COMPRESS_GZIP` | Enable GZIP compression when sending to loki host                                                | `TRUE`                   |          |         |
| `FLUENTBIT_OUTPUT_LOKI_HOST`          | Host for Loki Output                                                                             | `loki`                   |          | x       |
| `FLUENTBIT_OUTPUT_LOKI_PORT`          | Port for Loki Output                                                                             | `3100`                   |          | x       |
| `FLUENTBIT_OUTPUT_LOKI_TLS`           | Enable TLS For Loki Output                                                                       | `FALSE`                  |          |         |
| `FLUENTBIT_OUTPUT_LOKI_TLS_VERIFY`    | Enable TLS Certificate Verification For Loki Output                                              | `FALSE`                  |          |         |
| `FLUENTBIT_OUTPUT_LOKI_USER`          | (optional) Username to authenticate to Loki Server                                               | ``                       |          | x       |
| `FLUENTBIT_OUTPUT_LOKI_PASS`          | (optional) Password to authenticate to Loki Server                                               | ``                       |          | x       |
| `FLUENTBIT_OUTPUT_TENANT_ID`          | (optional) Tenant ID to pass to Loki Server                                                      | ``                       |          | x       |
| `FLUENTBIT_OUTPUT`                    | Output plugin to use `LOKI` , `FORWARD`, `NULL`                                                  | `FORWARD`                |          |         |
| `FLUENTBIT_TAIL_BUFFER_CHUNK_SIZE`    | Buffer Chunk Size for Tail                                                                       | `32k`                    | x        |         |
| `FLUENTBIT_TAIL_BUFFER_MAX_SIZE`      | Maximum size for Tail                                                                            | `32k`                    | x        |         |
| `FLUENTBIT_TAIL_READ_FROM_HEAD`       | Read from Head instead of Tail                                                                   | `FALSE`                  |          |         |
| `FLUENTBIT_TAIL_SKIP_EMPTY_LINES`     | Skip Empty Lines when Tailing                                                                    | `TRUE`                   |          |         |
| `FLUENTBIT_TAIL_SKIP_LONG_LINES`      | Skip Long Lines when Tailing                                                                     | `TRUE`                   |          |         |
| `FLUENTBIT_TAIL_DB_ENABLE`            | Enable Offset DB per tracked file (will be same name as log file yet hidden and a suffix of `db` | `TRUE`                   |          |         |
| `FLUENTBIT_TAIL_DB_SYNC`              | DB Sync Type `normal` or `full`                                                                  | `normal`                 |          |         |
| `FLUENTBIT_TAIL_DB_LOCK`              | Lock access to DB File                                                                           | `TRUE`                   |          |         |
| `FLUENTBIT_TAIL_DB_JOURNAL_MODE`      | Journal Mode for DB `WAL` `DELETE` `TRUNCATE` `PERSIST` `MEMORY` `OFF`                           | `WAL`                    | x        |         |
| `FLUENTBIT_TAIL_KEY_PATH_ENABLE`      | Enable sending Key for Log Filename/Path                                                         | `TRUE`                   |          |         |
| `FLUENTBIT_TAIL_KEY_PATH`             | Path Key Name                                                                                    | `filename`               |          |         |
| `FLUENTBIT_TAIL_KEY_OFFSET_ENABLE`    | Enable sending Key for Offset in Log file                                                        | `FALSE`                  |          |         |
| `FLUENTBIT_TAIL_KEY_OFFSET`           | Offset Path Key Name                                                                             | `offset`                 |          |         |
| `FLUENTBIT_SETUP_TYPE`                | Automatically generate configuration based on these variables `AUTO` or `MANUAL`                 | `AUTO`                   |          |         |
| `FLUENTBIT_STORAGE_BACKLOG_LIMIT`     | Maximum about of memory to use for backlogged/unsent records                                     | `5M`                     |          |         |
| `FLUENTBIT_STORAGE_CHECKSUM`          | Create CRC32 checkcum for filesystem RW functions                                                | `FALSE`                  |          |         |
| `FLUENTBIT_STORAGE_PATH`              | Absolute file system path to store filesystem data buffers                                       | `/tmp/fluentbit/storage` |          |         |
| `FLUENTBIT_STORAGE_SYNC`              | Synchronization mode to store data in filesystem `normal` or `full`                              | `normal`                 | x        |         |

## Networking

| Port   | Protocol | Description |
| ------ | -------- | ----------- |
| `2020` | udp      | HTTP Server |

## References

* https://github.com/fluent/fluent-bit
* https://fluentbit.io
