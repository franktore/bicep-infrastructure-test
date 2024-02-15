param env string
param tagComponent string
param tagEnvironment string
param appConfigSku string

var keyVaultName = 's039-ioc-portal-kv-${env}'
var appConfigName = 's039-ioc-portal-appconf-${env}'
var vaultDnsSuffix = environment().suffixes.keyvaultDns

var keyValuePairs = [
  {
      name: 'EQUINOR_TENANT_ID$global'
      value: 2123
  }
  {
      name: 'EQUINOR_API_SUBSCRIPTION_KEY$backend'
      value: 'test'
  }
]
var keyVaultReferences = [
  {
      name: 'PUBLIC_IP$backend'
      value: {
          uri: 'https://${keyVaultName}${vaultDnsSuffix}/secrets/public-ip-address/'
      }
  }
]
var featureFlags = [
  {
      name: '.appconfig.featureflag~2FCA_EXT$feature'
      value: {
          id: 'CA_EXT'
          description: 'Toggle for CA Extension features'
          enabled: true
      }
  }
]

module appConfigModule 'br/CoreModulesDEV:appconfig:0.1' = {
  name: 'appConfigDeploy'
  scope: resourceGroup()
  params: {
    sku: appConfigSku
    appConfigName: appConfigName
    tagComponent: tagComponent
    tagEnvironment: tagEnvironment
    keyValuePairs: keyValuePairs
    featureFlags: featureFlags
    keyVaultReferences: keyVaultReferences
  }
}
