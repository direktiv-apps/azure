#!/bin/bash

if [[ -z "${DIREKTIV_TEST_URL}" ]]; then
	echo "Test URL is not set, setting it to http://localhost:9191"
	DIREKTIV_TEST_URL="http://localhost:9191"
fi

if [[ -z "${DIREKTIV_SECRET_azureUser}" ]]; then
	echo "Secret azureUser is required, set it with DIREKTIV_SECRET_azureUser"
	exit 1
fi

if [[ -z "${DIREKTIV_SECRET_azurePassword}" ]]; then
	echo "Secret azurePassword is required, set it with DIREKTIV_SECRET_azurePassword"
	exit 1
fi

if [[ -z "${DIREKTIV_SECRET_azureTenantID}" ]]; then
	echo "Secret azureTenantID is required, set it with DIREKTIV_SECRET_azureTenantID"
	exit 1
fi

docker run --network=host -v `pwd`/tests/:/tests direktiv/karate java -DtestURL=${DIREKTIV_TEST_URL} -Dlogback.configurationFile=/logging.xml -DazureUser="${DIREKTIV_SECRET_azureUser}" -DazurePassword="${DIREKTIV_SECRET_azurePassword}" -DazureTenantID="${DIREKTIV_SECRET_azureTenantID}"  -jar /karate.jar /tests/v1.0/karate.yaml.test.feature ${*:1}