SUBSCRIPTION        := 1d859091-2b3a-43df-b2be-f73c460fcc44
RESOURCE_GROUP_DEV  := S494-ioc-shared-rg-dev
RESOURCE_GROUP_PROD  := S494-ioc-shared-rg-prod

RUNID := $(shell date +%F.%H-%M-%S)

registry.deployment.dev:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file ./main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json

registry.deployment.prod:
	@echo "deploying Bicep to prod"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.prod.${RUNID}) \
		--template-file ./main.bicep \
		--resource-group $(RESOURCE_GROUP_PROD) \
		--parameters @./parameters/azuredeploy.parameters.prod.json

deployment.dev:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file ./main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json
