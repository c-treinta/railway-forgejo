RAILWAY_PROJECT ?= templates-test

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --service forgejo-app
	railway service status --all --json | jq -r '.[] | select(.name == "forgejo-app") | .id' | xargs -I{} railway volume -s {} add --mount-path /data
	railway up app --path-as-root --service forgejo-app
	railway variable set --service forgejo-app \
	  PORT=3000 \
	  FORGEJO__database__DB_TYPE=postgres \
	  'FORGEJO__database__HOST=$${{Postgres.PGHOST}}:$${{Postgres.PGPORT}}' \
	  'FORGEJO__database__NAME=$${{Postgres.PGDATABASE}}' \
	  'FORGEJO__database__USER=$${{Postgres.PGUSER}}' \
	  'FORGEJO__database__PASSWD=$${{Postgres.PGPASSWORD}}' \
	  FORGEJO__server__ROOT_URL=https://forgejo.railway.com \
	  FORGEJO__server__DOMAIN=forgejo.railway.com

destroy:
	@echo "Delete services via Railway dashboard: forgejo-app, Postgres"
	@echo "https://railway.com/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service forgejo-app --lines 100

.PHONY: deploy destroy status logs
