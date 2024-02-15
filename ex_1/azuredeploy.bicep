param registryName string
param env string
param sku string = 'Basic'
param location string = resourceGroup().location
param tags object = {
  environment: env
  project: 'shared-infrastructure'
}

var serverPath = '${registryName}.azurecr.io'

resource registry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: registryName
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: true
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'disabled'
      }
    }
    encryption: {
      status: 'disabled'
    }
    dataEndpointEnabled: false
    publicNetworkAccess: 'Enabled'
  }
}

output acrServerUrl string = serverPath
