# SuiteCRM Dockerized Setup

This repository contains a Dockerized setup of the open-source CRM platform **[SuiteCRM](https://github.com/SuiteCRM/SuiteCRM)**. The goal is to provide a **reproducible, scalable, and production-ready environment** using Docker.

---

## 📦 Overview

SuiteCRM is a PHP-based CRM system that requires:

* PHP (Apache)
* MySQL database
* Composer dependencies

This project containerizes the entire setup using:

* 🐳 Docker
* 📦 Docker Compose
* ⚙️ Multi-stage builds for optimization

---

## 🧱 Architecture

```
User → SuiteCRM App (PHP + Apache) → MySQL Database
```

### Services:

| Service      | Description                    |
| ------------ | ------------------------------ |
| `app`        | SuiteCRM application container |
| `db`         | MySQL 5.7 database             |
| `phpmyadmin` | Optional DB management UI      |

---

## 🚀 Getting Started

### 1. Clone Repository

```bash
git clone https://github.com/SuiteCRM/SuiteCRM.git
cd SuiteCRM
```

---

### 2. Add Docker Configuration

Ensure the following files exist in the root:

* `Dockerfile`
* `docker-compose.yml`
* `php.ini`
* `apache.conf`

---

### 3. Build & Run Containers

```bash
docker-compose up -d --build
```

---

### 4. Access Application

* SuiteCRM → http://localhost:8080
* phpMyAdmin → http://localhost:8081

---

## ⚙️ Dockerization Approach

🔹 Single-Stage Docker Build

This setup uses a single-stage Dockerfile, where:

PHP 8.2 with Apache is used as the base image
System dependencies and PHP extensions are installed
Composer is installed inside the container
Application source code is copied into the container
Composer dependencies are installed during build

🔹 Key Steps in Dockerfile
Install system dependencies and PHP extensions
Enable Apache modules (mod_rewrite)
Install Composer
Copy application source code
Run composer install
Set correct file permissions
Apply custom PHP and Apache configurations

### 🔹 Key Optimizations

* ✅ Reduced image size using multi-stage builds
* ✅ Removed dev dependencies
* ✅ Cleaned package cache
* ✅ Optimized Composer autoload
* ✅ No Composer in production image

---

### 🔹 PHP Configuration

Custom `php.ini` is used to support SuiteCRM requirements:

```ini
upload_max_filesize = 50M
post_max_size = 50M
memory_limit = 512M
max_execution_time = 300
```

---

### 🔹 Apache Configuration

* Enabled `mod_rewrite`
* Configured document root
* Allowed `.htaccess` overrides

---

## 🗄 Database Configuration

Default credentials:

| Key      | Value    |
| -------- | -------- |
| Host     | db       |
| Database | suitecrm |
| User     | suitecrm |
| Password | suitecrm |

---

## 📁 Important Directories

These directories must be writable:

* `cache/`
* `custom/`
* `modules/`
* `themes/`
* `upload/`

They are created and permissioned during container build.

---
### ⚠️ PHP Version Compatibility

* Recommended: **PHP 8.1 / 8.2**
* Ensure compatibility with your SuiteCRM version

---

## 🧪 Troubleshooting

### Composer Autoloader Error

```bash
docker exec -it suitecrm_app composer install
```

---

### Permission Issues

```bash
docker exec -it suitecrm_app bash
chown -R www-data:www-data /var/www/html
chmod -R 775 cache custom modules themes upload
```

---

### Port Conflict

Change port in `docker-compose.yml`:

```yaml
ports:
  - "8082:80"
```

---

## 🛠 Tech Stack

* PHP 8.2 (Apache)
* MySQL 5.7
* Docker & Docker Compose
* Composer

---

## 🏆 Key Benefits

* One-command setup
* Environment consistency
* Production-ready container
* Easy deployment to Kubernetes
* Scalable architecture

---

## 📌 Future Improvements

* Add Nginx reverse proxy
* Enable HTTPS (Let's Encrypt)
* Integrate Redis caching
* CI/CD pipeline (GitHub Actions)
* Helm charts for Kubernetes

---

## 📄 License

This project is based on SuiteCRM, which is open-source under its respective license.



## 💡 Final Note

This setup transforms SuiteCRM into a **modern, containerized application**, making it easier to develop, deploy, and scale across environments.

---
