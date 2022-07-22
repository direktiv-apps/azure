
# azure 1.0

Run azure in Direktiv

---
- #### Categories: unknown
- #### Image: gcr.io/direktiv/apps/azure 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/azure/issues
- #### URL: https://github.com/direktiv-apps/azure
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About azure

This function provides Azure's cli. The supported authentication mechanism is via service principal.  This requires user and tenant ID and a secret. How to create a service principal for Azure is explained  [Microsoft's Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal). If extensions are needed they are downloaded automatically and the followinf extensions are already installed:
- ssh
- containerapp
- k8s-configuration
- k8s-extension
- k8sconfiguration
- connectedk8s
- connectedmachine
- connectedvmware

The output is set to JSON via the environment variable AZURE_CORE_OUTPUT but can be overwritten with '--output'. If commands a long running Azure cli presents a "progress bar" in Stdout. In this case the response is not JSON because  there are strings printed into the Stdout stream. In this case run the command to create and then a second to describe the  created entity.

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: azure
  image: gcr.io/direktiv/apps/azure:1.0
  type: knative-workflow
```
   #### Basic
```yaml
- id: azure
  type: action
  action:
    function: azure
    input: 
      commands:
      - command: Example of running azure
```
   #### Advanced
```yaml
- id: azure
  type: action
  action:
    function: azure
    input: 
      files:
      - name: hello.txt
        data: Hello World
        mode: '0755'
      commands:
      - command: Example of running azure
```

   ### Secrets


- **azureUser**: User ID of the app for the service
- **azurePassword**: The password is the token generated in "Certificates & secrets" in "App registrations". The app needs to have a role assigned in the subscription to work. 
- **azureTenantID**: Tenant ID provided by Azure.






### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
[
  {
    "result": null,
    "success": true
  },
  {
    "result": null,
    "success": true
  }
]
```

### Errors
| Type | Description
|------|---------|
| io.direktiv.command.error | Command execution failed |
| io.direktiv.output.error | Template error for output generation of the service |
| io.direktiv.ri.error | Can not create information object from request |


### Types
#### <span id="post-o-k-body"></span> postOKBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| azure | [][PostOKBodyAzureItems](#post-o-k-body-azure-items)| `[]*PostOKBodyAzureItems` |  | |  |  |


#### <span id="post-o-k-body-azure-items"></span> postOKBodyAzureItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| result | [interface{}](#interface)| `interface{}` | ✓ | |  |  |
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| auth | [PostParamsBodyAuth](#post-params-body-auth)| `PostParamsBodyAuth` | ✓ | |  |  |
| commands | [][PostParamsBodyCommandsItems](#post-params-body-commands-items)| `[]*PostParamsBodyCommandsItems` |  | | Array of commands. |  |
| files | [][DirektivFile](#direktiv-file)| `[]apps.DirektivFile` |  | | File to create before running commands. |  |


#### <span id="post-params-body-auth"></span> postParamsBodyAuth

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| password | string| `string` | ✓ | | The secret created under "Certificates & Secrets" | `S0m3~Cr8zy~P855word` |
| tenant | string| `string` | ✓ | | Azure tenant ID | `a433dd122-bcdf-1605-160b-09717b123456` |
| user | string| `string` | ✓ | | The application ID of the app registration for the principal | `a433dd122-bcdf-1605-160b-09717b123456` |


#### <span id="post-params-body-commands-items"></span> postParamsBodyCommandsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| command | string| `string` |  | | Command to run |  |
| continue | boolean| `bool` |  | | Stops excecution if command fails, otherwise proceeds with next command |  |
| print | boolean| `bool` |  | `true`| If set to false the command will not print the full command with arguments to logs. |  |
| silent | boolean| `bool` |  | | If set to false the command will not print output to logs. |  |

 
