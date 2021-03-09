$forge = New-Object System.Management.Automation.Host.ChoiceDescription '&Forge', 'Server Type: Forge. For modded servers.'
$paper = New-Object System.Management.Automation.Host.ChoiceDescription '&Paper', 'Server Type: Spigot. For plugin only servers.'
$vanilla = New-Object System.Management.Automation.Host.ChoiceDescription '&Vanilla', 'Server Type: Vanilla. For plane and simple minecraft servers.'

$options = [System.Management.Automation.Host.ChoiceDescription[]]($forge, $paper, $vanilla)

$param1=$args[0]
write-host "MCSH Server Creation Tool" -ForegroundColor Blue -BackgroundColor Black 
$name = Read-Host "Please enter a server name"
$type = $host.ui.PromptForChoice('Server Type', 'What kind of server are we deploying?', $options, 2)
$memory = Read-Host "Alright, and how much memory?"
$ = Read-Host "Alright, and how much memory?"