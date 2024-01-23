# Mouse HWIDs; adjust
$mouse1Hwid = ""
$mouse2Hwid = ""

function Toggle-MouseState {
    param (
        [string]$HardwareId,
        [string]$Action # "Enable" or "Disable"
    )

    $deviceInstancePath = (Get-PnpDevice | Where-Object { $_.HardwareID -like "*$HardwareId*" }).InstanceID
    if (!$deviceInstancePath) {
        Write-Host "Device with Hardware ID $HardwareId not found"
        return
    }

    if ($Action -eq "Enable") {
        Write-Host "Enabling device with Hardware ID $HardwareId"
        Enable-PnpDevice -InstanceId $deviceInstancePath -Confirm:$false
    } elseif ($Action -eq "Disable") {
        Write-Host "Disabling device with Hardware ID $HardwareId"
        Disable-PnpDevice -InstanceId $deviceInstancePath -Confirm:$false
    }
}

$mouse1 = Get-PnpDevice | Where-Object { $_.HardwareID -like "*$mouse1Hwid*" }
if ($mouse1.Status -eq "OK") {
    Toggle-MouseState -HardwareId $mouse1Hwid -Action "Disable"
    Toggle-MouseState -HardwareId $mouse2Hwid -Action "Enable"
} else {
    Toggle-MouseState -HardwareId $mouse2Hwid -Action "Disable"
    Toggle-MouseState -HardwareId $mouse1Hwid -Action "Enable"
}

