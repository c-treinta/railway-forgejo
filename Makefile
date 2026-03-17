RAILWAY_PROJECT ?= templates-test

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --service forgejo-app
	railway volume -s forgejo-app add --mount-path /data
	cd app && railway up --service forgejo-app
	railway variable set --service forgejo-app \
	  FORGEJO__database__DB_TYPE=postgres \
	  'FORGEJO__database__HOST=${{Postgres.PGHOST}}:${{Postgres.PGPORT}}' \
	  'FORGEJO__database__NAME=${{Postgres.PGDATABASE}}' \
	  'FORGEJO__database__USER=${{Postgres.PGUSER}}' \
	  'FORGEJO__database__PASSWD=${{Postgres.PGPASSWORD}}' \
	  FORGEJO__server__ROOT_URL=https://forgejo.railway.app \
	  FORGEJO__server__DOMAIN=forgejo.railway.app

destroy:
	@echo "Delete services via Railway dashboard: forgejo-app, Postgres"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service forgejo-app --lines 100

.PHONY: deploy destroy status logs
