# Deploy and Host Forgejo on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/TEMPLATE_ID)

Forgejo is a self-hosted, lightweight Git service — a community-driven fork of Gitea. It provides Git repository hosting, issue tracking, pull requests, CI/CD pipelines, and a full web interface for collaborative software development.

## About Hosting Forgejo

Hosting Forgejo requires a persistent volume to store repositories, configuration files, and attachments across redeployments. It also depends on a PostgreSQL database for metadata storage. On Railway, Forgejo runs as a single Docker-based service backed by a Railway-managed Postgres instance. The `FORGEJO__` environment variable prefix maps directly to Forgejo's `app.ini` configuration, making it straightforward to tune the server without mounting custom config files.

## Common Use Cases

- Self-hosted alternative to GitHub or GitLab for private or team source code
- Internal code review and pull request workflows without third-party SaaS
- Lightweight CI/CD trigger point for small teams or homelab setups
- Mirror hosting for open-source projects that want independence from major platforms
- Git hosting for air-gapped or compliance-sensitive environments

## Dependencies for Forgejo Hosting

- PostgreSQL (Railway-managed)
- Persistent volume mounted at `/data`

### Deployment Dependencies

- Docker image: [codeberg.org/forgejo/forgejo](https://codeberg.org/forgejo/forgejo)
- Forgejo configuration reference: [Forgejo Config Cheat Sheet](https://forgejo.org/docs/latest/admin/config-cheat-sheet/)
- Forgejo environment-to-ini docs: [Environment Variables](https://forgejo.org/docs/latest/admin/environment-variables/)

### Implementation Details

Forgejo is configured entirely via `FORGEJO__<section>__<key>` environment variables using the environment-to-ini system. Database credentials are injected from the Railway-managed Postgres service using reference variables (e.g., `${{Postgres.PGHOST}}`). The `/data` volume persists repositories, LFS objects, avatars, and app config across deploys.

## Why Deploy Forgejo on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Forgejo on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
