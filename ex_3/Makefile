SUBSCRIPTION        := 1d859091-2b3a-43df-b2be-f73c460fcc44
RESOURCE_GROUP_DEV  := S494-ioc-shared-rg-dev
REGISTRY_NAME := S494iocsharedbregdev
BICEP_FILE := ../modules/webAppResource.bicep
MODULE_NAME := webapp
VERSION := 0.1

RUNID := $(shell date +%F.%H-%M-%S)

publish:
	@echo "publishing Bicep to bicep registry"
	az bicep publish \
	--file $(BICEP_FILE) \
	--target br:$(REGISTRY_NAME).azurecr.io/bicep/modules/$(MODULE_NAME):$(VERSION)

deploy:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json

deploy.final:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file final_main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json
