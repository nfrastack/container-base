# Container Base Addon - MSMTP

## Purpose

Allows the ability to send SMTP messages from container

## Availability

* Alpine (all variants)
* Debian (all variants)

## Configuration Files

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.

| Parameter                  | Description                                       | Default         | Advanced | `_FILE` |
| -------------------------- | ------------------------------------------------- | --------------- | -------- | ------- |
| `MSMTP_BINARY`             | Binary to use                                     | `msmtp`         | x        |         |
| `SMTP_AUTO_FROM`           | Add setting to support sending through Gmail SMTP | `FALSE`         |          |         |
| `SMTP_HOST`                | Hostname of SMTP Server                           | `postfix-relay` |          | x       |
| `SMTP_PORT`                | Port of SMTP Server                               | `25`            |          | x       |
| `SMTP_DOMAIN`              | HELO Domain                                       | `docker`        |          |         |
| `SMTP_MAILDOMAIN`          | Mail Domain From                                  | `local`         |          |         |
| `SMTP_AUTHENTICATION`      | SMTP Authentication                               | `none`          |          |         |
| `SMTP_USER`                | SMTP Username                                     | ``              |          | x       |
| `SMTP_PASS`                | SMTP Password                                     | ``              |          | x       |
| `SMTP_TLS`                 | Use TLS                                           | `FALSE`         |          |         |
| `SMTP_STARTTLS`            | Start TLS from within session                     | `FALSE`         |          |         |
| `SMTP_TLSCERTCHECK`        | Check remote certificate                          | `FALSE`         |          |         |
| `SMTP_ALLOW_FROM_OVERRIDE` | SMTP Allow From Override                          | ``              |          |         |

## References

* https://github.com/marlam/msmtp
* https://marlam.de/msmtp