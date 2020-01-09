﻿$ErrorActionPreference = 'STOP'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$defaultFolder = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
if ( $pp.InstallDir ) {
    $installDir = $pp.InstallDir
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
    mkdir -force $installDir -ea 0 | out-null
} else {
  $installDir = $defaultFolder
}

$packageArgs = @{
    packageName    = 'python3'
    fileType       = 'exe'
    file           = "$toolsPath\python-3.9.0a2.exe"
    file64         = "$toolsPath\python-3.9.0a2-amd64.exe"
    silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
    validExitCodes = @(0)
    softwareName   = 'Python*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' }}

$installLocation = Get-AppInstallLocation python
if ($installLocation -ne $installDir) {
    Write-Warning "Provided python InstallDir was ignored by the python installer"
    Write-Warning "Its probable that you had pre-existing python installation"
    Write-Warning "Installed to: $installLocation"
 } else { Write-Host "Installed to: '$installDir'" }

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
    Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

. "$toolsPath/helpers.ps1"
Protect-InstallFolder `
  -packageName $packageArgs["packageName"] `
  -defaultInstallPath $defaultFolder `
  -folder $installLocation
