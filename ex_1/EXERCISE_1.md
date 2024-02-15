# Exercise 1: deploying a bicep resource

We'll run through the fundamentals, then we'll start with a pre-defined ARM-template and convert it into an equivalent bicep-file ready for deployment.

## prerequisites
* az cli >= 2.20.0
* vscode
* vscode extensions:
    * Bicep
    * Azure Resource Manager (ARM) Tools

## Bicep fundamentals
Bicep is a declarative language, which means the elements can appear in any order. Unlike imperative languages, the order of elements doesn't affect how deployment is processed.

The following elements make up a bicep file:

```
metadata <metadata-name> = ANY

targetScope = '<scope>'

type <user-defined-data-type-name> = <type-expression>

func <user-defined-function-name> (<argument-name> <data-type>, <argument-name> <data-type>, ...) <function-data-type> => <expression>

@<decorator>(<argument>)
param <parameter-name> <parameter-data-type> = <default-value>

var <variable-name> = <variable-value>

resource <resource-symbolic-name> '<resource-type>@<api-version>' = {
  <resource-properties>
}

module <module-symbolic-name> '<path-to-file>' = {
  name: '<linked-deployment-name>'
  params: {
    <parameter-names-and-values>
  }
}

output <output-name> <output-data-type> = <output-value>
```

#### Metadata
 in Bicep is an untyped value that can be included in Bicep files. It allows you to provide supplementary information about your Bicep files, including details like its name, description, author, creation date, and more.

#### Target scope
By default, the target scope is set to resourceGroup. If you're deploying at the resource group level, you don't need to set the target scope in your Bicep file.

The allowed values are:

resourceGroup - default value, used for resource group deployments.
subscription - used for subscription deployments.
managementGroup - used for management group deployments.
tenant - used for tenant deployments.
In a module, you can specify a scope that is different than the scope for the rest of the Bicep file. For more information, see Configure module scope

#### Types
You can use the type statement to define user-defined data types, like

`type storageAccountSkuType = 'Standard_LRS' | 'Standard_GRS'`

#### Functions
In your Bicep file, you can create your own functions in addition to using the standard Bicep functions that are automatically available within your Bicep files. Create your own functions when you have complicated expressions that are used repeatedly in your Bicep files.

#### Parameters
Use parameters for values that need to vary for different deployments. You can define a default value for the parameter that is used if no value is provided during deployment.

#### Parameter decorators
You can add one or more decorators for each parameter. These decorators describe the parameter and define constraints for the values that are passed in.

#### Variables
You can make your Bicep file more readable by encapsulating complex expressions in a variable.

#### Resources
Use the resource keyword to define a resource to deploy. Your resource declaration includes a symbolic name for the resource. You use this symbolic name in other parts of the Bicep file to get a value from the resource.

The resource declaration includes the resource type and API version. Within the body of the resource declaration, include properties that are specific to the resource type.

#### Modules
Modules enable you to reuse code from a Bicep file in other Bicep files. In the module declaration, you link to the file to reuse. When you deploy the Bicep file, the resources in the module are also deployed.

The symbolic name enables you to reference the module from somewhere else in the file. For example, you can get an output value from a module by using the symbolic name and the name of the output value.

#### Resource and module decorators
You can add a decorator to a resource or module definition. The supported decorators are batchSize(int) and description. You can only apply it to a resource or module definition that uses a for expression.

By default, resources are deployed in parallel. When you add the batchSize(int) decorator, you deploy instances serially.

#### Outputs
Use outputs to return values from the deployment. Typically, you return a value from a deployed resource when you need to reuse that value for another operation.

ex.

`output storageEndpoint object = stg.properties.primaryEndpoints`

#### Loops
You can add iterative loops to your Bicep file to define multiple copies of a:

* resource
* module
* variable
* property
* output

Use the for expression to define a loop.

#### Conditional deployment
You can add a resource or module to your Bicep file that is conditionally deployed. During deployment, the condition is evaluated and the result determines whether the resource or module is deployed.

Use the if expression to define a conditional deployment.

#### Whitespace
Spaces and tabs are ignored when authoring Bicep files.

Bicep is newline sensitive.

#### Comments
Use // for single-line comments or /* ... */ for multi-line comments.

#### Multi-line strings
You can break a string into multiple lines. Use three single quote characters ''' to start and end the multi-line string.

Characters within the multi-line string are handled as-is. Escape characters are unnecessary. You can't include ''' in the multi-line string. String interpolation isn't currently supported.

## Getting started: Decompile from JSON to Bicep
When you use Azure CLI with Bicep, you have everything you need to deploy and decompile Bicep files. Azure CLI automatically installs the Bicep CLI when a command is executed that needs it.

to decompile ARM-template to Bicep, use:

`az bicep decompile --file main.json`

```
Decompilation attempts to convert the file, but there is no guaranteed mapping from ARM template JSON to Bicep. You may need to fix warnings and errors in the generated Bicep file. Or, decompilation can fail if an accurate conversion isn't possible.
```

## Deploy resources to Azure
We made a simple makefile for the deployment which will deploy the content of our bicep file by running

`make deployment.dev BICEP_FILE=my.bicep`

## Explore
You can download all resources in an existing resource-group into a file with the following command

`az group export --name "your_resource_group_name" > main.json`

If you do this you will have to manually fix all that is not correctly transferred into the file
The resulting json can then be decompiled into a bicep equivalent.

However! we recommend building your infrastructure from scratch, using the shared resources found in `ioc-shared-infrastrucure`
