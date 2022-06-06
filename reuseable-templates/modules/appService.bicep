/*INPUT PARAMETERS*/
param environmentName string
param location string
param solutionName string

/*MODULE ONLY PARAMETERS*/


@minValue(1)
@maxValue(10)
param appServicePlanInstanceCount int = 1

param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
}

/*VARIABLES*/
var appServicePlanName = '${environmentName}-${solutionName}-plan'
var appServiceAppName = '${environmentName}-${solutionName}-app'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku:{
    name: appServicePlanSku.name
    tier: appServicePlanSku.tier
    capacity: appServicePlanInstanceCount
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

