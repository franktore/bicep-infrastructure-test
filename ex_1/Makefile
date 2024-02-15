SUBSCRIPTION        := 24d1df90-df6d-4d34-9f8d-e4bbb9c5e9e4
RESOURCE_GROUP_DEV  := s039-ioc-shared-rg-dev
BICEP_FILE 			:= main.bicep

RUNID := $(shell date +%F.%H-%M-%S)

deployment.dev:
	@echo "deploying Bicep to dev"
	az deployment group create \
		--mode Incremental \
		--name $(shell echo shared.dev.${RUNID}) \
		--template-file ./$(BICEP_FILE) \
		--resource-group $(RESOURCE_GROUP_DEV) \
		--parameters @./parameters/azuredeploy.parameters.dev.json
