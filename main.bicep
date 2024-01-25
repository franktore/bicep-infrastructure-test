@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string
@description('Provide a location for the registry.')
param location string = resourceGroup().location
@description('Provide a tier of your Azure Container Registry.')
param acrSku string = 'Basic'

module acrModule 'modules/containerregistry.bicep' = {
  name: 'bicepRegistryDeploy'
  scope: resourceGroup()
  params: {
    name: acrName
    location: location
    sku: acrSku
    adminUserEnabled: false
  }
}

param env string
param tagComponent string
param tagEnvironment string
param appConfigSku string = 'Standard'

module appConfModule 'appconf.bicep' = {
  name: 'appConfDeploy'
  scope: resourceGroup()
  params: {
    env: env
    tagComponent: tagComponent
    tagEnvironment: tagEnvironment
    appConfigSku: appConfigSku
  }
}
