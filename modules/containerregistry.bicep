@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param name string = 'myacr'
@description('Provide a location for the registry.')
param location string = resourceGroup().location
@description('Provide a tier of your Azure Container Registry.')
param sku string = 'Basic'
@description('Enable admin user for the registry.')
param adminUserEnabled bool = true

resource acrResource 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: adminUserEnabled
  }
}

@description('Output the login server property for later use')
output loginServer string = acrResource.properties.loginServer
