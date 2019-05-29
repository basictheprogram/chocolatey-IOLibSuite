$ErrorActionPreference = 'Stop'; 

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$workSpace    = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"
$fileLocation = 'N:\gold-images\keysight-iolib\Keysight IO Libraries Suite 2019.msi'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $workSpace
  fileType       = 'MSI'
  fileFullPath   = $fileLocation
  softwareName   = 'IOLibSuite*'
  checksum       = 'c318426c510b092e7ba4ceed5e1cd90e12f456a3adfec060f190acb7a2503912'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 APIINSTALL=0 LICENSETYPE=0"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs 
