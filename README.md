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
- **Prometheus + Grafana**: Monitoring stack
- **Static Website**: Simple static site

## Project Structure

```
.
├── Makefile
├── secrets/           # Contains all sensitive information
└── srcs/
    ├── docker-compose.yaml
    └── requirements/
        ├── mariadb/
        ├── nginx/
        ├── wordpress/
        ├── redis/      # Bonus
        ├── adminer/    # Bonus
        ├── ftp/        # Bonus
        ├── prometheus/ # Bonus
        ├── grafana/    # Bonus
        └── website/    # Bonus
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

# Clean all containers and volumes and remove ~/data directory
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
- Tested with CI and Github Secrets

## Notes

- NGINX is the only entry point to the infrastructure via port 443
- All containers restart automatically in case of a crash
