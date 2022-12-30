.PHONY: install-dep
install-dep:
	docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions