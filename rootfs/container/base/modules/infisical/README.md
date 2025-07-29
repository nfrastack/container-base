# Container Base Addon - Infisical

## Purpose

Securely fetch and manage secrets in your containerized environment. It supports multiple formats for secrets (`dotenv`, `json`, `yaml`, `varval`) and provides flexibility in how secrets are stored and accessed.

## Availability

* Alpine 3.17 and later
* Debian (all variants)

## How it works

### How Secrets Are Processed

### Authentication
The Infisical CLI is used to authenticate with the API:
```bash
infisical login -i --token "${INFISICAL_TOKEN}" --api-url "${INFISICAL_API_URL}"
```

### Secrets Export
Secrets are exported using the `infisical export` command:
```bash
infisical export --format="${SECRET_TYPE}" --env="${SECRET_ENV}" --projectId="${SECRET_PROJECT_ID}"
```

### Handling `SECRET_TYPE`
- **`dotenv`**: Secrets are written to a single `.env` file.
- **`json`**: Secrets are written to a single `.json` file.
- **`yaml`**: Secrets are written to a single `.yaml` file.
- **`varval`**:
  - Secrets are first exported in `dotenv` format.
  - The `.env` file is parsed, and each key-value pair is written to an individual file.

### Result
- If `SECRET_TYPE=dotenv`:
  - A single `.env` file is created at `/run/secrets/my_source.env`.
- If `SECRET_TYPE=varval`:
  - Individual files are created for each secret key, e.g.:
    ```
    /run/secrets/DB_PASSWORD
    /run/secrets/API_KEY
    ```

### File Ownership and Permissions
All secret files are assigned the specified ownership and permissions:
```bash
chown "${SECRET_FILE_USER}":"${SECRET_FILE_GROUP}" "${file}"
chmod "${SECRET_FILE_PERMISSIONS}" "${file}"
```



## Configuration Files

## Environment Variables

* Variables showing an 'x' under the `_FILE` column can be used for storing the information inside of a file, useful for secrets.
* Variables showing an 'x' under teh `Advanced` column can only be set if the containers advanced functionality is enabled.
*
| Parameter                   | Description                                                           | Default                         | Advanced | `_FILE` |
| --------------------------- | --------------------------------------------------------------------- | ------------------------------- | -------- | ------- |
| `INFISICAL_API_URL`         | Base URL for the Infisical API.                                       | `https://app.infisical.com/api` |          | x       |
| `INFISICAL_CREATE_ENV`      | Whether to create environment variables from secrets.                 | `TRUE`                          |          |         |
| `INFISICAL_DELETE_ENV`      | Whether to delete environment variables after use.                    | `TRUE`                          |          |         |
| `INFISICAL_LOG_LEVEL`       | Log Level                                                             | `info`                          |          |         |
| `INFISICAL_SECRETS_FLATTEN` | Whether to flatten secrets into individual files (`TRUE` or `FALSE`). | `FALSE`                         |          |         |
| `INFISICAL_TOKEN`           | Token for authenticating with Infisical.                              | None                            |          | x       |
| `SECRET_ENV`                | Environment to fetch secrets from (e.g., `dev`, `staging`, `prod`).   | None                            |          |         |
| `SECRET_FILE_GROUP`         | Group ownership for secret files.                                     | `root`                          |          |         |
| `SECRET_FILE_PERMISSIONS`   | File permissions for secret files.                                    | `0644`                          |          |         |
| `SECRET_FILE_USER`          | User ownership for secret files.                                      | `root`                          |          |         |
| `SECRET_PROJECT_ID`         | Project ID in Infisical to fetch secrets for.                         | None                            |          |         |
| `SECRET_SOURCE`             | Source name for secrets (used for naming files).                      | None                            |          |         |
| `SECRET_TARGET_PATH`        | Directory where secrets will be written.                              | `/var/run/secrets/infisical`                  |          |         |
| `SECRET_TYPE`               | Format for secrets export (`dotenv`, `json`, `yaml`, `varval`).       | `varval`                        |          |         |

### Supported `SECRET_TYPE` Values

| **Type** | **Description**                                                                                     |
| -------- | --------------------------------------------------------------------------------------------------- |
| `dotenv` | Exports secrets to a single `.env` file in `KEY=VALUE` format.                                      |
| `json`   | Exports secrets to a single `.json` file.                                                           |
| `yaml`   | Exports secrets to a single `.yaml` file.                                                           |
| `varval` | Exports secrets as individual files, where each file is named after the key and contains the value. |

## References

* https://github.com/infisical/cli
* https://infisical.com
