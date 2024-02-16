SUBSCRIPTION        := 1d859091-2b3a-43df-b2be-f73c460fcc44
RESOURCE_GROUP_DEV  := S494-ioc-shared-rg-dev
BICEP_FILE 			:= main.bicep

RUNID := $(shell date +%F.%H-%M-%S)

login:
	@echo "logging in to Azure"
	az login
	@echo "setting subscription to $(SUBSCRIPTION)"
	az account set --subscription $(SUBSCRIPTION)

deployment.dev:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file ./$(BICEP_FILE) \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json

keyvault.deployment:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file ./main.bicep \
		--resource-group $(RESOURCE_GROUP_DEV) \
