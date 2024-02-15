# BICEP Resource Management
Bicep offers a much cleaner and simpler interface to Azure Resource Management then raw ARM-templates.

Essentially Bicep is a wrapper for ARM, and will compile into ARM during the deployment-stage.
Hence there are commands for converting from one to the other when required.

Once resources are defined in Bicep we need a versioning system to be able to update without affecting other projects.
The current versioning is based on tagging commits to the `master`-branch in github.
This system is alright, but the downside is that you have to always accept all changes in all resources just to get the one you need.
When converting to bicep we will be using a different system for versioning. One that will give us control at the individual resource level, and which allows us to create specialized versions just for our own use or for testing-purposes.

By employing a shared container registry deployment and versioning strategy we gain flexibility and transparency compared to the shared repository-strategy (with great flexibility comes great responsibility. So `ask` before you `do` in cases of uncertainty).

We will still be using github for keeping track of changes. There is no need to switch to a new repository, we will be using the `ioc-shared-infrastructure` repo as before. We will also leave all the ARM templates as they are so that we can convert to bicep at our own pace.

The conversion to bicep in `ioc-shared-infrastructure` is a team effort, and we hope ppl will be contributing to it as they start using bicep in their own projects.

Here follows some guidelines of how to use the Bicep resources and how to contribute.

## prerequisites
* az cli >= 2.20.0
* vscode
* vscode extensions:
    * Bicep
    * Azure Resource Manager (ARM) Tools

When you use Azure CLI with Bicep, you have everything you need to deploy and decompile Bicep files. Azure CLI automatically installs the Bicep CLI when a command is executed that needs it.

## Decompile from JSON to Bicep

to decompile ARM-template to Bicep, use:

`az bicep decompile --file main.json`

```
Decompilation attempts to convert the file, but there is no guaranteed mapping from ARM template JSON to Bicep. You may need to fix warnings and errors in the generated Bicep file. Or, decompilation can fail if an accurate conversion isn't possible.
```

## Useful Commands

`az bicep publish --file {mymodule}.bicep --target br:{registryname}.azurecr.io/bicep/modules/{mymodule}:{version}`

or using the parameters in the `bicepconfig` file simply

`az bicep publish --file {mymodule}.bicep --target br/CoreModules:{mymodule}:{version}`

References:

* https://zure.com/blog/sharing-bicep-templates-and-modules/
* https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/private-module-registry?tabs=azure-cli
* https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-config-modules
* https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-bicep?tabs=CLI
* https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-config
* https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-config?source=recommendations
* https://learn.microsoft.com/en-us/training/modules/test-bicep-code-using-azure-pipelines/
* https://github.com/Azure/bicep/discussions/6024
* https://learn.microsoft.com/en-us/cli/azure/bicep?view=azure-cli-latest
* https://azure.github.io/Azure-Verified-Modules/contributing/bicep/bicep-contribution-flow/validate-bicep-module-locally/
* https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices
* https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-cli#restore
