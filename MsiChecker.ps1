$result = Get-WmiObject -Class Win32_Product

Write-Output "Installed MSIs:"
$result | Format-List Name, Version

$appName = "InstEd"
$exists = $result | Where {$_.Name -like 'InstEd*' }

if ($exists -ne $null) {
    Write-Output "$appName is installed on this device."
} else {
    Write-Output "$appName is not installed on this device."
}