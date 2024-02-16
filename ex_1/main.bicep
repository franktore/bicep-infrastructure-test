@allowed([
  'dev'
  'test'
  'prod'
])
@description('The environment of the resources (dev, test or prod).')
param environment string = 'dev'

var tenantId = '3aa4a235-b6e2-48d5-9195-7fcf05b459b0'
var tagComponent = 'Shared'
var tagEnvironment = '${toUpper(first(environment))}${toLower(skip(environment,1))}'
var keyVaultName = 'S494-ioc-shared-kv-${environment}'
var rgScope = resourceGroup()

module keyvaultResourceDeploy 'keyvault.bicep' = {
  name: 'keyvaultResourceDeploy'
  scope: rgScope
  params: {
    environment: environment
    keyVaultName: keyVaultName
    tagComponent: tagComponent
    tagEnvironment: tagEnvironment
    tenantId: tenantId
  }
}
