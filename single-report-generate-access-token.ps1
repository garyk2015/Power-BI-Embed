# Parameters
$clientId = "<Your_Client_ID>"
$clientSecret = "<Your_Client_Secret>"
$tenantId = "<Your_Tenant_ID>"
$resourceUri = "https://analysis.windows.net/powerbi/api"
$authorityUri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$scope = "https://analysis.windows.net/powerbi/api/.default"

# Get the access token
$body = @{
client_id     = $clientId
scope         = $scope
client_secret = $clientSecret
grant_type    = "client_credentials"
}
$response = Invoke-RestMethod -Method Post -Uri $authorityUri -Body $body
$accessToken = $response.access_token

# Define Power BI API details
$groupId = "<Your_Workspace_ID>"
$reportId = "<Your_Report_ID>"
# REST API endpoint to generate the embed token
$embedTokenUri = "https://api.powerbi.com/v1.0/myorg/groups/$groupId/reports/$reportId/GenerateToken"
# Body for the request
$body = @{
    accessLevel = "View"
} | ConvertTo-Json

# Headers with the access token
$headers = @{
"Content-Type" = "application/json"
"Authorization" = "Bearer $accessToken"
}
# Call the API
$embedTokenResponse = Invoke-RestMethod -Uri $embedTokenUri -Method Post -Body $body -Headers $headers
$embedToken = $embedTokenResponse.token
# Print the embed token to console for copying
Write-Output "Your Power BI Embed Token is:"
Write-Output $embedToken
