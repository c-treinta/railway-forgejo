# Forgejo

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/c-treinta/railway-forgejo)

Self-hosted Git service (Gitea fork).

**Services:** `forgejo-app`, `Postgres` (Railway-managed)
**Persistent volume:** `/data` (repos, config, attachments)

## Deploy

```bash
make deploy
```

## Post-Deploy

Update `ROOT_URL` and `DOMAIN` to your actual Railway domain:
```bash
railway variable set --service forgejo-app \
  FORGEJO__server__ROOT_URL=https://your-domain.railway.app \
  FORGEJO__server__DOMAIN=your-domain.railway.app
```
