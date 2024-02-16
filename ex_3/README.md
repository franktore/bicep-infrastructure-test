# Exercise 3: Using bicep registry for sharing and versioning
To share our bicep with others we will use a bicep registry.
We'll publish resources to the bicep registry.
We then use the published resources to deploy new resources to our resource-group.

## Publishing the resources to registry
Our created modules currently only exist locally.
When publishing to a registry they can be versioned and shared between developers and accessed from pipelines.

To publish our resource-files to the registry we can run

`az bicep publish --file my.bicep --target br:{registryname}.azurecr.io/bicep/modules/{mymodule}:{version}`

or we can simply call `make publish`.

This will effectively push the resource to the bicep registry with the specified version number.

Notice if you try running the same command twice it fails. This is because the specified version already exists. You either have to change version number or use the `--force` flag to publish again.

## Using the registry in our deployment

Now that we can convert ARM to Bicep and publish modules to registry we will start deploying our resources directly from our registry

To call a module from the registry we change our deployment file (i.e. `main.bicep`) like so:

```
module bcrModule '../modules/containerregistry.bicep' --> module bcrModule 'br:S494iocsharedbregdev.azurecr.io/bicep/modules/containerregistry:<version>'
```

you may have to run the restore command to update your local module-cache, but this normally should not be required

`az bicep restore --file <bicep-file> [--force]`

To test it run `make deploy`

## Configure your Bicep environment with `bicepconfig`
Bicep supports an optional configuration file named bicepconfig.json. Within this file, you can add values that customize your Bicep development experience.

To customize configuration, create a configuration file in the same directory or a parent directory of your Bicep files. If there are multiple parent directories containing bicepconfig.json files, Bicep uses the configuration from the nearest one.

In addition to adding linters and analyzers we will use the config file to configure our bicep modules.
We can add aliases for module paths to simplify our bicep files and to separate between environments.

ex. `bicepconfig.json`

```
{
  "moduleAliases": {
    "br": {
      "IocRegistryDEV": {
        "registry": "S494iocsharedbregdev.azurecr.io"
      },
      "CoreModulesDEV": {
        "registry": "S494iocsharedbregdev.azurecr.io",
        "modulePath": "bicep/modules"
      },
      "IocRegistryPROD": {
          "registry": "S494iocsharedbregprod.azurecr.io"
        },
        "CoreModulesPROD": {
          "registry": "S494iocsharedbregprod.azurecr.io",
          "modulePath": "bicep/modules"
        }
    }
  }
}
```


The `CoreModulesPROD` specified in the `bicepconfig.json` links to `S494iocsharedbregprod.azurecr.io/bicep/modules`. The acronym `br` simply stands for `Bicep Registry`. For development or testing one may use `CoreModulesDEV` which links to an equivalent registry found here `S494iocsharedbregdev.azurecr.io/bicep/modules`.

Our deployment file can now be changed to
```
module bcrModule 'br:S494iocsharedbregdev.azurecr.io/bicep/modules/containerregistry:<version>' --> module bcrModule 'br/CoreModulesDEV:containerregistry:<version>'
```

run make `deploy.final` to test that it works.

### Learn more
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-config
