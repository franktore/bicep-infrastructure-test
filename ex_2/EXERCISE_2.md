# Exercise 2

We'll publish resources to the bicep container registry.
We then use the published resources to deploy new resources.

## Choose a resource to convert


## Publishing the resource
Lets deploy our resource-file to the registry we created in the previous exercise

`az bicep publish --file my.bicep --target br:{registryname}.azurecr.io/bicep/modules/{mymodule}:{version}`
