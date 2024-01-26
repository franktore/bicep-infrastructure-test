@allowed([
  'dev'
  'test'
  'prod'
])
@description('Set the environment.')
param env string
@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string
@description('Provide a location for the registry.')
param location string = resourceGroup().location
@description('Provide a tier of your Azure Container Registry.')
param acrSku string = 'Standard'
@description('Provide a tag for your Azure Container Registry Environment.')
param tagEnvironment string
@description('The SKU of the App Configuration.')
param appConfigSku string = 'Standard'

module acrModule 'modules/containerregistry.bicep' = {
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

// module appConfModule 'appconf.bicep' = {
//   name: 'appConfDeploy'
//   scope: resourceGroup()
//   params: {
//     env: env
//     tagEnvironment: tagEnvironment
//     tagComponent: 'Shared'
//     appConfigSku: appConfigSku
//   }
// }
