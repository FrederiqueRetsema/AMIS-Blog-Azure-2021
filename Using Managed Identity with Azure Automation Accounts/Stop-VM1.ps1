# Stop vm1
# --------
# This PowerShell script supports the blog "Using Manaqged Identity with Azure Automation" on the 
# AMIS Technology Blog (https://technology.amis.nl)

Connect-AzAccount -Identity
$ResourceGroupName = Get-AutomationVariable -Name ResourceGroupName
Stop-AzVM -Name vm1 -ResourceGroupName $ResourceGroupName -Force