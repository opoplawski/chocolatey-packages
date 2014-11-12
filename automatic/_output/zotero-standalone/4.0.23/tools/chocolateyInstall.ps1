﻿$packageName = 'zotero-standalone'
$installerType = 'EXE'
$url = 'http://download.zotero.org/standalone/4.0.23/Zotero-4.0.23_setup.exe' # download url
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
