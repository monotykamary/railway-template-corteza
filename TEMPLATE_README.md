# Deploy and Host Corteza on Railway

## About Hosting Corteza

Corteza is an open-source low-code platform for data applications, records, workflows, reports, privacy tooling, roles, and integrations. This template deploys stable version 2024.9.10 with PostgreSQL and generated super-administrator credentials.

Sign in with `CORTEZA_ADMIN_EMAIL` and the generated `CORTEZA_ADMIN_PASSWORD` service variable.

## Common Use Cases

- Build internal CRM, case-management, and operational data apps
- Model records and relationships without starting from a blank codebase
- Automate workflows and enforce role-based access
- Create reports and privacy workflows around business data

## Dependencies for Corteza Hosting

### Deployment Dependencies

- Corteza all-in-one web and API service with daily-backed-up object storage
- Private PostgreSQL 17.7 with daily backups
- Optional external SMTP, Corredor, object storage, and observability services

### Implementation Details

The adapter runs Corteza upgrades and built-in provisioning on startup, idempotently creates the generated super administrator through the CLI, and then starts the API plus embedded webapps. Stable generated JWT, cookie, and CSRF secrets survive redeploys. PostgreSQL and uploaded objects use separate persistent volumes.

This is a one-replica starter. Validate shared object storage and multi-replica behavior before scaling horizontally.

## Why Deploy Corteza on Railway?

Railway provides managed HTTPS, generated credentials, private PostgreSQL networking, persistent volumes with backups, health checks, and Git-driven deployment for a complete low-code platform.
