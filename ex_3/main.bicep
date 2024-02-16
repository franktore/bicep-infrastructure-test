@allowed([
  'dev'
  'test'
  'prod'
])
@description('Set the environment.')
param env string
@minLength(5)
@maxLength(46)
@description('Provide a globally unique name of your Azure Container Registry')
param registryName string
@description('Provide a name for your App Configuration.')
param appConfigName string
@description('Provide a location for the registry.')
param location string = resourceGroup().location
@description('Provide a tier of your Azure Container Registry.')
param acrSku string = 'Standard'
@description('Provide a tag for your Azure Container Registry Environment.')
param tagEnvironment string
@description('The SKU of the App Configuration.')
param appConfigSku string = 'Standard'

var acrName = '${registryName}${env}'
var appConfigFullName = '${appConfigName}${env}'

module bcrModule 'br:S494iocsharedbregdev.azurecr.io/bicep/modules/containerregistry:0.1' = {
  name: 'bicepRegistryDeploy'
  scope: resourceGroup()
  params: {
    registryName: acrName
    location: location
    sku: acrSku
    tags: {
      Environment: tagEnvironment
      Component: 'Shared'
    }
    adminUserEnabled: false
  }
}

module appConfModule 'br:S494iocsharedbregdev.azurecr.io/bicep/modules/appconfig:0.1' = {
  name: 'appConfDeploy'
  scope: resourceGroup()
  params: {
    appConfigName: appConfigFullName
    tagEnvironment: tagEnvironment
    tagComponent: 'Shared'
    sku: appConfigSku
  }
}
