$VHDOpenedFilePathProfile = (Get-ItemProperty -Path HKCU:\SOFTWARE\FSLogix\Profiles\Session\ -Name VHDOpenedFilePath).VHDOpenedFilePath
$VHDOpenedFilePathODFC = (Get-ItemProperty -Path HKCU:\SOFTWARE\FSLogix\ODFC\Session\ -Name VHDOpenedFilePath).VHDOpenedFilePath
$VHDDisks = @($VHDOpenedFilePathProfile,$VHDOpenedFilePathODFC)

Foreach ($d in $VHDDisks) {
$VHDDisk = Get-DiskImage -ImagePath $d | Select-Object FileSize,Size,ImagePath
$FileSize = ($VHDDisk.FileSize)/1gb
$Size = ($VHDDisk.Size)/1gb
$Usage = ($FileSize/$Size).tostring("P")
Write-Host("Disk: " + (Split-Path ($VHDDisk.ImagePath) -leaf)) -ForegroundColor Cyan
Write-Host("Size on Disk(GB): " + $FileSize) -ForegroundColor Cyan
Write-Host("Disk Usage: " + $Usage) -ForegroundColor Cyan
Write-Host
}