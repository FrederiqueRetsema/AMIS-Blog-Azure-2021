# Runbook CheckRunAsAccountsInCurrentSubscription
# ===============================================

# Connect-AzAccount
# -----------------

Connect-AzAccount -identity

#  ====
#  Main
#  ====

Write-Output "TRACE: Start runbook CheckRunAsAccountsInAllSubscriptionsInRunbook.ps1"

$errorsFound = $false

$automationAccountResources = (Get-AzResource -ResourceType Microsoft.Automation/automationAccounts) 
Foreach ($automationAccountResource in $automationAccountResources) 
{
    $automationAccount = Get-AzAutomationAccount -Name $automationAccountResource.Name -ResourceGroup $automationAccountResource.ResourceGroupName
    $connection = $automationAccount | Get-AzAutomationConnection

    if ($connection -ne $null) 
    {
        Write-Error "ERROR: Automation account $($automationAccountResource.Name): RunAs account used: connection $($connection.Name) exists, connection type: $($connection.ConnectionTypeName), description: ""$($connection.Description)"""
        $errorsFound = $true
    }
    else
    {
        Write-Output "INFO: Automation account $($automationAccountResource.Name): No RunAs account used"
    }

}

if ($errorsFound) {
    Write-Error "ERROR: Errors found, throw error 'RunAs accounts present'"
    Throw "RunAs accounts present"
}
