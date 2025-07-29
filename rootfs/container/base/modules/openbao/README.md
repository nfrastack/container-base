# Container Base Addon - Openbao

## Purpose

Integrates with the OpenBao secrets backend to securely fetch and manage secrets in your containerized environment. It supports fetching secrets in `dotenv` or `varval` formats and provides flexibility in how secrets are stored and accessed.

## Availability

* Alpine 3.17 and later
* Debian (all variants)

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.

| Parameter                 | Description                                                           | Default        | Advanced | `_FILE` |
| ------------------------- | --------------------------------------------------------------------- | -------------- | -------- | ------- |
| `SECRET_HOST`             | Base URL for the Vault/Openbao API                                    | None           |          | x       |
| `SECRET_TOKEN`            | Token for authenticating with Vault/Openbao API                       | None           |          | x       |
| `SECRET_TYPE`             | Format for secrets export (`dotenv` or `varval`).                     | `varval`       |          |         |
| `SECRET_TARGET_PATH`      | Directory where secrets will be written.                              | `/run/secrets` |          |         |
| `SECRET_SOURCE`           | Source name for secrets (used for naming files).                      | None           |          |         |
| `SECRET_FILE_USER`        | User ownership for secret files.                                      | `root`         |          |         |
| `SECRET_FILE_GROUP`       | Group ownership for secret files.                                     | `root`         |          |         |
| `SECRET_FILE_PERMISSIONS` | File permissions for secret files.                                    | `0644`         |          |         |
| `OPENBAO_CREATE_ENV`      | Whether to create environment variables from secrets.                 | `TRUE`         |          |         |
| `OPENBAO_DELETE_ENV`      | Whether to delete environment variables after use.                    | `TRUE`         |          |         |
| `OPENBAO_SECRETS_FLATTEN` | Whether to flatten secrets into individual files (`TRUE` or `FALSE`). | `FALSE`        |          |         |

### Supported `SECRET_TYPE` Values

| **Type** | **Description**                                                                                     |
| -------- | --------------------------------------------------------------------------------------------------- |
| `dotenv` | Exports secrets to a single `.env` file in `KEY=VALUE` format.                                      |
| `varval` | Exports secrets as individual files, where each file is named after the key and contains the value. |

## References

* https://github.com/openbao/openbao
* https://openbao.org
