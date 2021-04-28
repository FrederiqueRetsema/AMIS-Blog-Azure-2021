# Stop vm1
# --------
# This PowerShell script supports the blog "Using a Managed Identity with Azure Automation Accounts" on the 
# AMIS Technology Blog (https://technology.amis.nl)

Connect-AzAccount -Identity
$ResourceGroupName = Get-AutomationVariable -Name ResourceGroupName
Stop-AzVM -Name vm1 -ResourceGroupName $ResourceGroupName -Force