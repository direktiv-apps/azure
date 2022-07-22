
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:
* def azureUser = karate.properties['azureUser']
* def azurePassword = karate.properties['azurePassword']
* def azureTenantID = karate.properties['azureTenantID']
* configure readTimeout = 240000

Scenario: get request

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{	
		"auth": {
			"user": "#(azureUser)",
			"password": "#(azurePassword)",
			"tenant": "#(azureTenantID)"
		},
		"commands": [
		
		{
			"command": "az containerapp env show --name del8 --resource-group app-svc",
			"silent": false,
			"print": true,
		}
		]
	}
	"""
	When method POST
	Then status 200
		And match $ ==
	"""
	{
	"azure": [
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""
	