/*___________________________________________________________________________
 Developed by _______________________________________________________________|
     ________              ________   _________    _______   __  _________
     \____   \_______      \____   \ |__\   _  \   \      \ |__|/   _____/
      |    |  \_  __ \      |    |  \|  /  /_\  \  /   |   \|  |\_____  \
      |    |   \  | \/      |    |   \  \  \_/   \/    |    \  |/        \
      /_______  /__|   /\  /_______  /__|\_____  /\____|__  /__/_______  /
              \/       \/          \/          \/         \/           \/
 _______________________                           ____________ © 1990 - 2020
|_______________________| Mons†rum est in nostrum |__________________________|

История изменений:
	* - Изменение функционала
	+ - Расширение функционала
	- - Сокращение функционала

25.09.2020(v1.0) * - Начало разработки, написание основного кода приложения.
*/
!include LogicLib.nsh

!define Version "1.0.0.0"

Name "FarManagerPortable"
Icon "App\AppInfo\appicon.ico"
OutFile "FarManagerPortable.exe"

VIProductVersion ${Version}
VIAddVersionKey "FileVersion" ${Version}
VIAddVersionKey "ProductVersion" ${Version}
VIAddVersionKey "LegalCopyright" "Denis «Dr.Di0NiS» Nemtsov © 1990-2020"
VIAddVersionKey "FileDescription" "Far Manager Portable Launcher"

Var Bits
Var ConEmu
Var AppPath

SilentInstall silent
RequestExecutionLevel user

Function .onInit
	System::Call "kernel32::GetCurrentProcess()i.s"
	System::Call "kernel32::IsWow64Process(is,*i.r0)"
	StrCmpS $0 0 +3
	StrCpy $Bits 64
	Goto +2
	StrCpy $Bits 32
	System::Call "kernel32::GetCurrentDirectory(i ${NSIS_MAX_STRLEN}, t .r0)"
	StrCpy $AppPath $0
	IfFileExists $AppPath\App\ConEmu\ConEmu.exe 0 +3
	StrCpy $ConEmu 'true'
	Goto +2
	StrCpy $ConEmu 'false'
FunctionEnd

Section
  ${Switch} $Bits
	${Case} '32'
		${If} $ConEmu == 'true'
			Exec '$AppPath\App\ConEmu\ConEmu.exe -run $AppPath\App\x86\Far.exe -s "$AppPath\Data\Far Manager\Profile"'
		${Else}
  			Exec '$AppPath\App\x86\Far.exe -s "$AppPath\Data\Far Manager\Profile"'
		${EndIf}
	${Break}
	${Case} '64'
		${If} $ConEmu == 'true'
			Exec '$AppPath\App\ConEmu\ConEmu64.exe -run $AppPath\App\x64\Far.exe -s "$AppPath\Data\Far Manager\Profile"'
		${Else}
  			Exec '$AppPath\App\x64\Far.exe -s "$AppPath\Data\Far Manager\Profile"'
		${EndIf}
	${Break}
  ${EndSwitch}
SectionEnd