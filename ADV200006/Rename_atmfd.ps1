# Author:  testbugonly  <testbugonly@gmail.com>
# Create:  24 Mar 2020
# Name  :  Rename atmfd.dll
# Info : Adv200006 mitigation measures

$info = systeminfo
$type = $info | Select-String -Pattern 'based PC'
$path0 = ($info | Select-String -Pattern 'system32') -split ' ' | Select-String -Pattern "C:"
$path1 = Get-Childitem -Path C:\Windows\ -Filter syswow64
$file = Get-Childitem -Path $path0 -Filter atmfd.dll

sleep(10)

if ($type -cmatch 'x64'){
Start-Process powershell -Verb runAs "cd $path0" 
Start-Process powershell -Verb runAs  "takeown.exe /f atmfd.dll"
Start-Process powershell -Verb runAs  "icacls.exe atmfd.dll /save atmfd.dll.acl"
Start-Process powershell -Verb runAs  "icacls.exe --% atmfd.dll /grant Administrators:(F)"
Start-Process powershell -Verb runAs  "rename-item atmfd.dll old-atmfd.dll"
Start-Process powershell -Verb runAs  "cd C:\Windows\syswow64"
Start-Process powershell -Verb runAs  "takeown.exe /f atmfd.dll'"
Start-Process powershell -Verb runAs  "icacls.exe atmfd.dll /save atmfd.dll.acl'"
Start-Process powershell -Verb runAs  "icacls.exe atmfd.dll /grant Administrators:(F)'"
Start-Process powershell -Verb runAs  "rename atmfd.dll old-atmfd.dll'"
}

if ($type -cmatch 'x86'){
Start-Process powershell -Verb runAs  "cd $path0" 
Start-Process powershell -Verb runAs  "takeown.exe /f atmfd.dll'"
Start-Process powershell -Verb runAs  "icacls.exe atmfd.dll /save atmfd.dll.acl'"
Start-Process powershell -Verb runAs  "icacls.exe atmfd.dll /grant Administrators:(F)'"
Start-Process powershell -Verb runAs  "rename atmfd.dll old-atmfd.dll'"
}



if ($path1 -notlike 'syswow64'){
	Write-Host "Not Found :syswow64！Call Security Administrator!!"
}
elseif ($file -like 'atmfd.dll'){
	Write-Host "Call Security Administrator!!"
}
else {
	Write-Host "Any key to exit. And Your computer will restart"
}

sleep(5)

Read-Host | Out-Null ;
Restart-Computer
