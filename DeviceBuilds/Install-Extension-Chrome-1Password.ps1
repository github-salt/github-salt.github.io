# Define the registry paths
$chromeRegPath = "HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist"

# Define the extensions to add
$extensions = @(
    "aeblfdkhhhdcdjpifhhbdiojplfjncoa" #, # 1Password
    # "baipgmmeifmofkcilhccccoipmjccehn" # 3cx Click to call
)

# repository.github.io\DeviceSetupFunctions.ps1
Add-BrowserExtensions -regPath $chromeRegPath -extensions $extensions

# $Results = Get-Item $chromeRegPath | Get-ItemProperty | Select-Object * -ExcludeProperty PSProvider

# $Results | ConvertTo-Json

