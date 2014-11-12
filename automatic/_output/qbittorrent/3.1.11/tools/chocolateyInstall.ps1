﻿$packageName = 'qbittorrent'
$installerType = 'exe'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-3.1.11/qbittorrent_3.1.11_setup.exe/download'
$silentArgs = '/S'
$validExitCodes = @(0, 1223)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
