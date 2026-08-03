# Corteza on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/corteza-low-code?referralCode=ZqgrJ0)

Deploy Corteza 2024.9.9 with embedded web applications, a generated super administrator, PostgreSQL, and durable object storage.

The Deploy on Railway button is added after the published route is verified.

## What this deploys

- Corteza `2024.9.9` all-in-one server and webapps, pinned to the official image digest
- PostgreSQL `17.7-bookworm`, pinned to its Linux/AMD64 digest and initialized below the volume mount via `PGDATA`
- Generated administrator, JWT, cookie, CSRF, and database secrets
- Daily-backed-up Corteza object storage and PostgreSQL volumes

## Sign in

Open the generated domain and sign in with `CORTEZA_ADMIN_EMAIL` and `CORTEZA_ADMIN_PASSWORD` from the Corteza service variables. The adapter runs schema upgrades, then idempotently creates the super administrator through Corteza's production-safe CLI before starting HTTP. Corteza performs its built-in service provisioning while the CLI and server initialize.

## Scope

The all-in-one image includes Admin, Compose, Workflow, Reporter, and Privacy web applications. Corredor automation scripts, external SMTP, object storage providers, and observability integrations are not enabled by default. The template uses a local `/data/store` volume for uploaded objects and one application replica.

Corteza is a platform rather than a prebuilt business application. Administrators still need to model namespaces, modules, records, workflows, roles, and integrations for their use case.

## Updating

Update Corteza and PostgreSQL versions and immutable digests deliberately, back up both volumes, review release migrations, then repeat login, namespace/record workflows, object persistence, database persistence, and redeploy soak tests.

## Validation

```bash
npm test
BASE_URL=https://your-domain.example ADMIN_EMAIL=admin@example.com ADMIN_PASSWORD=... python3 scripts/smoke.py
```

## Upstream

- Source: https://github.com/cortezaproject/corteza/tree/2024.9.9
- Release: https://github.com/cortezaproject/corteza/releases/tag/2024.9.9
- Documentation: https://docs.cortezaproject.org/
- License: Apache License 2.0

This repository contains Railway adapters and documentation. Corteza remains copyright Planet Crust and contributors and is not affiliated with Railway.
