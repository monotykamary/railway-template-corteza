# Corteza 2024.9 → 2026.9

The [official upgrade guide](https://docs.cortezaproject.org/corteza-docs/2026.9/devops-guide/upgrade/202609.html) says the database schema upgrades automatically at startup. Preserve both volumes and every generated authentication secret; back up the database and attachments first. PostgreSQL remains on its existing 17.x line.

2026.9 contains security fixes not backported to 2024.9. Review changed authorization behavior before upgrading: contextual roles must use confirmed `user.email` or `user.labels`, workflow impersonation needs permission, attachment access is namespace-scoped, and email-notification APIs require the new permission. Existing custom integrations may need policy updates. See the [full changelog](https://docs.cortezaproject.org/corteza-docs/2026.9/changelog/index.html). Do not weaken these controls to preserve an old integration.

The candidate must preserve a namespace, module and actual record across old→new→redeploy. The product check mints only a temporary local admin token, never prints it, and uses real HTTP API requests. Railway HTTPS/login and post-redeploy soak remain separate release gates.
