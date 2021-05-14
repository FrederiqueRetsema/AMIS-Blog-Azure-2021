# CheckRunAsAccountsInAllSubscriptions.ps1
# ========================================

#  ====
#  Main
#  ====

Write-Output "TRACE: Start powershell script CheckRunAsAccountsInAllSubscriptions.ps1"

$subscriptions = Get-AzSubscription 

Foreach ($subscription in $subscriptions) 
{
    Write-Output "TRACE: Check for RunAs accounts in Automation Accounts in subscription $($subscription.Name)"
    Write-Output "TRACE: ---"
    Set-AzContext $subscription -Scope Process  | Out-Null

    $automationAccountResources = (Get-AzResource -ResourceType Microsoft.Automation/automationAccounts) 
    Foreach ($automationAccountResource in $automationAccountResources) 
    {
        $automationAccount = Get-AzAutomationAccount -Name $automationAccountResource.Name -ResourceGroup $automationAccountResource.ResourceGroupName
        $connection = $automationAccount | Get-AzAutomationConnection
        if ($connection -ne $null) 
        {
            Write-Warning "Automation account $($automationAccountResource.Name): RunAs account used: connection $($connection.Name) exists, connection type: $($connection.ConnectionTypeName), description: ""$($connection.Description)"""
        }
        else
        {
            Write-Output "INFO: Automation account $($automationAccountResource.Name): No RunAs account used"
        }
    }
    Write-Output "TRACE: ---"
}