param tenantId string
param environment string
param keyVaultName string
param tagComponent string
param tagEnvironment string

var sharedInfrastructureUri = 'https://raw.githubusercontent.com/equinor/ioc-shared-infrastructure/v0.2.8'
var iocITAdmins = 'cf3dc9a2-8da4-40c5-89c2-15ea70c2b903'  // IOC IT Administrator Group

resource keyvaultEnvironment 'Microsoft.Resources/deployments@2022-09-01' = {
  name: 'keyvault.${environment}'
  properties: {
    mode: 'Incremental'
    templateLink: {
      uri: '${sharedInfrastructureUri}/resources/resourceKeyVault/azuredeploy.jsonc'
      contentVersion: '1.0.0.0'
    }
    parameters: {
      keyVaultName: {
        value: keyVaultName
      }
      accessPolicies: {
        value: [
          {
            tenantId: tenantId
            objectId: iocITAdmins
            permissions: {
              keys: [
                'Get'
                'List'
                'Update'
                'Create'
                'Import'
                'Delete'
                'Recover'
                'Backup'
                'Restore'
              ]
              secrets: [
                'Get'
                'List'
                'Set'
                'Delete'
                'Recover'
                'Backup'
                'Restore'
                'Purge'
              ]
              certificates: [
                'Get'
                'List'
                'Update'
                'Create'
                'Import'
                'Delete'
                'Recover'
                'Backup'
                'Restore'
                'ManageContacts'
                'ManageIssuers'
                'GetIssuers'
                'ListIssuers'
                'SetIssuers'
                'DeleteIssuers'
              ]
            }
          }
        ]
      }
      tags: {
        value: {
          Component: tagComponent
          Environment: tagEnvironment
        }
      }
    }
  }
}
