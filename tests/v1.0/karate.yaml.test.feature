
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:
* def azureUser = karate.properties['azureUser']
* def azurePassword = karate.properties['azurePassword']
* def azureTenantID = karate.properties['azureTenantID']
* configure readTimeout = 240000

Scenario: listvm

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
			"command": "az vm list",
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
	
Scenario: appenv

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
			"command": "/usr/local/bin/az extension list",
			"silent": false,
			"print": true,
		}
		]
	}
	"""
	When method POST
	Then status 200