SUBSCRIPTION        := 24d1df90-df6d-4d34-9f8d-e4bbb9c5e9e4
RESOURCE_GROUP_DEV  := S039-ioc-shared-rg-dev
RESOURCE_GROUP_PROD  := S039-ioc-shared-rg-prod

RUNID := $(shell date +%F.%H-%M-%S)

registry.deployment.prod:
	@echo "deploying Bicep to dev"
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
