$ErrorActionPreference = 'Stop'; 

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$workSpace    = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"
$url          = 'https://download.keysight.com/AS/IOLibSuite_18_1_24130.exe?id=3027604&dl=1&authparam=1559100994_fd50d64e8f7f4e15d729ef26f16a35ff'
$fileLocation = 'N:\gold-images\keysight-iolib\IOLibSuite_18_1_24130.exe'

$extractArgs = @{
  Statements     = '/s /x /b"'+ $workSpace +'" /v"/qn"'
  ExetoRun       = $fileLocation
  checksum       = '6de849c7df31b71d4b01136ec1e66f75517a7f21cfbd23b0d6a8e26d450896c8'
  checksumType   = 'sha256'
  validExitCodes = @(-3, 0, 1603)
}
$exitCode = Start-ChocolateyProcessAsAdmin @extractArgs

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $workSpace
  fileType       = 'MSI'
  fileFullPath   = Join-Path $workSpace "Keysight IO Libraries Suite 2019.msi"
  softwareName   = 'IOLibSuite*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 APIINSTALL=0 LICENSETYPE=0"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs 
