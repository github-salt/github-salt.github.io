# repository.github.io\DeviceSetupFunctions.ps1

$HKLMregistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' # Path to Registry folder
$DiskSizeregistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\DiskSpaceCheckThresholdMB' # Path to max disk size key
# $TenantGUID = '000000-1234-1234-1234-68d3018236ed' # Change tenant ID to your client

$TenantGUID = $AAC.AccessControlTenantId

if ($TenantGUID.Length -ne 36) {
    $TenantGUID = try {
        $CurrentUserDomain = (& "$env:windir\system32\whoami.exe" /upn 2>&1) -split "@" | Select-Object -Last 1
        (Invoke-RestMethod -Uri ("https://accounts.accesscontrol.windows.net/" + $CurrentUserDomain + "/metadata/json/1")).realm
    }
    catch {
    }
}
if ($TenantGUID.Length -ne 36) {
    $TenantGUID = (Get-DsRegDeviceInfo).TenantId
}


# Create registry keys and items for OneDrive configuration
if (-not (Test-Path $HKLMregistryPath)) { 
    New-Item -Path $HKLMregistryPath -Force 
}

New-ItemProperty -Path $HKLMregistryPath -Name "KFMSilentOptIn" -Value "$($TenantGUID)" -PropertyType String -Force -ea SilentlyContinue ##OneDrive Backup (Redirection)

New-ItemProperty -Path $HKLMregistryPath -Name 'FilesOnDemandEnabled' -Value '1' -PropertyType DWORD -Force | Out-Null ##OneDrive cloud-only files default

New-ItemProperty -Path $HKLMregistryPath -Name 'KFMSilentOptInDesktop' -Value '1' -PropertyType DWORD -Force | Out-Null ##OneDrive redierct desktop
New-ItemProperty -Path $HKLMregistryPath -Name 'KFMSilentOptInDocuments' -Value '1' -PropertyType DWORD -Force | Out-Null ##OneDrive redierct documents
New-ItemProperty -Path $HKLMregistryPath -Name 'KFMSilentOptInPictures' -Value '1' -PropertyType DWORD -Force | Out-Null ##OneDrive redierct pictures

New-ItemProperty -Path $HKLMregistryPath -Name 'KFMSilentOptInWithNotification' -Value '0' -PropertyType DWORD -Force | Out-Null ##OneDrive Backup notifications off

New-ItemProperty -Path $HKLMregistryPath -Name 'SilentAccountConfig' -Value '1' -PropertyType DWORD -Force | Out-Null ##Enable silent OneDrive Login
