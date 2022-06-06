@description('The name of the environment. This must be dev, test or prod')
@allowed([
  'dev'
  'test'
  'prod'
])
param environmentName string = 'dev'

param location string = 'westeurope'

@description('The unique name of the solution.')
@minLength(5)
@maxLength(30)
param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'


module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    environmentName: environmentName
    location: location
    solutionName: solutionName
  }
}

module sqlDatabase 'modules/sqlDatabase.bicep' = {
  name: 'sqlDatabase'
  params: {
    environmentName: environmentName
    solutionName: solutionName
    location: location
  }
}


/*module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}
*/
