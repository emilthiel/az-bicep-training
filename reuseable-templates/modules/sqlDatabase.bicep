param environmentName string
param solutionName string
param location string

@secure()
@description('The admin login username for the SQL Server')
param sqlServerAdministratorLogin string

@secure()
@description('The admin login password for the SQL Server')
param sqlServerAdministratorPassword string

@secure()
@description('The name and tier for the SQL database SKU')
param sqlDatabasSku object

var sqlServerName = '${environmentName}-${solutionName}-sql'
var sqlDatabaseName = 'Employee'

resource sqlServer 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: sqlDatabaseSku.name
    tier: sqlDatabaseSku.tier
  }
}
