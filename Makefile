SUBSCRIPTION        := 24d1df90-df6d-4d34-9f8d-e4bbb9c5e9e4
RESOURCE_GROUP_DEV  := S039-ioc-portal-rg-dev

RUNID := $(shell date +%F.%H-%M-%S)

registry.deployment.dev:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo portal.dev.${RUNID}) \
		--template-file ./main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json

deployment.dev:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo portal.dev.${RUNID}) \
		--template-file ./main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json
