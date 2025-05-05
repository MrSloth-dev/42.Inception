# Inception

A Docker infrastructure project that creates a small virtualized environment with multiple services.

## Core Services

- **NGINX**: Web server with TLSv1.2/TLSv1.3 configuration
- **WordPress**: Content management system with PHP-FPM
- **MariaDB**: Database server

## Bonus Services

- **Redis**: Caching system for WordPress
- **Adminer**: Database management tool
- **FTP Server**: File Transfer Protocol service
- **Portainer**: Container management platform
- **Static Website**: Simple static site

## Project Structure

```
.
├── Makefile
├── secrets/           # Contains all sensitive information
└── srcs/
    ├── docker-compose.yaml
    ├── requirements
    └── bonus
        │   ├── adminer
        │   │   ├── conf
        │   │   └── tools
        │   ├── ftp
        │   │   ├── conf
        │   │   └── tools
        │   ├── portainer
        │   │   └── tools
        │   └── redis
        │       ├── conf
        │       └── tools
        ├── mariadb
        │   ├── conf
        │   └── tools
        ├── nginx
        │   ├── conf
        │   └── tools
        ├── portainer
        │   └── tools
        └── wordpress
            ├── conf
            └── tools

```

## Usage

```bash
# Build all containers
make build

# Start services
make up

# Stop services
make down

# Clean all containers and volumes
make clean
# Clean all containers, volumes and data persistent directory ( needs sudo permission)
make fclean
```

## Volumes

The project uses persistent volumes for:
- MariaDB data
- WordPress files

## Network

All services communicate through an internal Docker network called "inception".

## Security

- No passwords in Dockerfiles
- Environment variables for configuration
- Docker secrets for sensitive data
- TLS encryption for web traffic

## Notes

- NGINX is the only entry point to the infrastructure via port 443
- All containers restart automatically in case of a crash
