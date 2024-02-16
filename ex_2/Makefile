SUBSCRIPTION        := 1d859091-2b3a-43df-b2be-f73c460fcc44
RESOURCE_GROUP_DEV  := S494-ioc-shared-rg-dev

RUNID := $(shell date +%F.%H-%M-%S)

deploy:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json
