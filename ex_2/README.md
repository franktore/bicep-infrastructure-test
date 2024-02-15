# Exercise 2: creating and combining resources



## Choose a resource to convert

In this example we've chosen the `webAppResource`.

We start by decompiling into bicep

`az bicep decompile --file azuredeploy.jsonc`

We then go through the list of warnings and fix them manually.

Finally rename the file to reflect the type of resource it represents.

## Combine modules in a bicep deployment file

Now that we have a couple of resources defined lets place them in a separate folder that we'll call `modules/`.

We then create a new file, `main.bicep`.

Add the modules you want to deploy to the file.
Add all parameters and variables you need for the modules.
Create a parameter-file, like `azuredeploy.parameters.dev.json`, for parametrizing the different environments.

When you finish setting up the deployment file run 

`make deployment`

this will deploy the resources to the dev-environment.
