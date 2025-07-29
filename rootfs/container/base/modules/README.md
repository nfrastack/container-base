# Container Base Modules

This directory contains modular components that extend the functionality of the base container image. Each module is designed to be self-contained, allowing for easy integration, management, and customization of various features without modifying the core container structure.

## Overview

The modules system follows a plug-and-play architecture that enables:

## Module Structure

Each module typically contains the following structure:

```
modules/
├── module_name/
│   ├── README.md                    # Documentation for the module
│   ├── module                       # Install script for the module
│   └── rootfs/                      # Root filesystem overlay
│       └── container/
│           └── base/
│               ├── defaults/        # Default configuration values
│               ├── functions/       # Shell functions for the module
│               └── scripts/         # Executable scripts
```

This structure follows the overlay pattern, where module files are copied on top of the base container filesystem during build time, extending the functionality without modifying the core files.

## Using Modules

### Enabling/Disabling Modules

Modules can be enabled or disabled using the `IMAGE_MODULES` environment variable or build argument:

```bash
IMAGE_MODULES="+module1,+module2,-module3"  # Enable module1, module2, disable module3
```

The `+` prefix enables a module, while the `-` prefix disables it.

### Git-based Modules

Modules can also be installed from Git repositories using the following syntax:

```bash
IMAGE_MODULES="+git:https://git.repo/user/repo.git#v1.0.0"
```

This will clone the specified repository into `/container/modules/repo` and check out the specified tag or branch (in this case, `v1.0.0`).

### Module Configuration

Each module can be configured using environment variables, typically prefixed with the module name (e.g., `APP_` for the 'APP' module).
See the README.md file in each module directory for specific configuration options.
