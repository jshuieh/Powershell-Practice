$properties = @("ProductName", "ProductVersion")

Function Get-Info ($path) {
    $msiFile = Get-Item -Path $path
    $installer = New-Object -ComObject WindowsInstaller.Installer
    $database = $installer.GetType().InvokeMember("OpenDatabase", "InvokeMethod", $null, $installer, @($msiFile.FullName, 0))

    forEach ($prop in $properties) {
        $query = "SELECT Value FROM Property WHERE Property = '$( $prop )'"
        $view = $database.GetType().InvokeMember("OpenView", "InvokeMethod", $null, $database, ($query))
        $view.GetType().InvokeMember("Execute", "InvokeMethod", $null, $view, $null)
        $record = $view.GetType().InvokeMember("Fetch", "InvokeMethod", $null, $view, $null)
        $value = $record.GetType().InvokeMember("StringData", "GetProperty", $null, $record, 1)
        Write-Output "$prop`: $value"
    }

    $database.GetType().InvokeMember("Commit", "InvokeMethod", $null, $database, $null)
    $view.GetType().InvokeMember("Close", "InvokeMethod", $null, $view, $null)           
    $database = $null
    $view = $null
}

$result = Get-WmiObject -Class Win32_Product

Write-Output "Installed MSIs:"
$result

$appName = "InstEd"
$exists = $result | Where {$_.Name -like 'InstEd*' }

if ($exists -ne $null) {
    Write-Output "$appName is installed on this device.`n"
} else {
    Write-Output "$appName is not installed on this device.`n"
}


forEach ($file in $result) {
    Get-Info($file.LocalPackage)
    Write-Output ""
}



