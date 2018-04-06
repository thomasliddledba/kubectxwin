PS2EXE-GUI v0.5.0.10
Release: 2018-03-29

Overworking of the great script of Igor Karstein with GUI support by Markus Scholtes.

The GUI output and input is activated with one switch, real windows executables
are generated.

https://gallery.technet.microsoft.com/scriptcenter/PS2EXE-GUI-Convert-e7cb69d5


All of you know the fabulous script PS2EXE by Ingo Karstein you can download here: PS2EXE : "Convert" PowerShell Scripts to EXE Files.

Unfortunately Ingo seems to have stopped working on his script so I overworked his script with some error fixes, improvements and output support for non-console WinForms scripts (parameter -noConsole to ps2exe.ps1).



GUI support:

- expanded every output and input function like Write-Host, Write-Output, Write-Error, Out-Default, Prompt, ReadLine to use WinForms message boxes or input boxes automatically when compiling a GUI application (Write-Progress is still missing)
- no console windows appears, real windows executables are generated
- just compile with switch "-noConsole" for this feature (i.e. .\ps2exe.ps1 .\output.ps1 .\output.exe -noConsole)
- see remarks below for formatting of output in GUI mode


I made the following important fixes and improvements:

Update v0.5.0.10 (2018-03-29):
- Get-Credential is assuming a generic login so no "\user" is returned if domain name is not set
Update v0.5.0.9 (2018-01-04):
- added takeover of caption and message for $host.UI.PromptForCredential and Get-Credential.
Update v0.5.0.8 (2017-12-05):
- $ERRORACTIONPREFERENCE = 'Stop' bug corrected. The last error is not swallowed anymore.
Update v0.5.0.7 (2017-10-10):
- parameter parsing bug corrected. A slash is not accepted as an introducing character for named parameters anymore.
Update v0.5.0.6 (2017-05-31):
- button texts for input boxes corrected, tries now to use localized strings for OK and Cancel
Update v0.5.0.5 (2017-05-02):
- new parameters -title, -description, -company, -product, -copyright, -trademark and -version to set meta data of executable (most of them appear in tab "Details" of properties dialog in Windows Explorer)
- new parameter -requireAdmin generates an executable that requires administrative rights and forces the UAC dialog (if UAC is enabled)
- new parameter -virtualize generates an executable that uses application virtualization when accessing protected system file system folders or registry
- several minor fixes
Update v0.5.0.4 (2017-04-04):
- corrected input handler: advanced parameters ([CmdletBinding()]) are working for compiled scripts now
- implemented input pipeline (only of strings) for compiled scripts (only Powershell V3 and above), e.g, Get-ChildItem | CompiledScript.exe
- Powershell V2 (or PS2EXE with switch -runtime20) compiles with .Net V3.5x compiler rather than with .Net V2.0 compiler now (there is no Microsoft support for .Net V2 anymore, so I won't support either)
- implemented missing console screen functions to move, get and set screen blocks (see example ScreenBuffer.ps1)
- several minor fixes
Update v0.5.0.3 (2017-03-08):
- Write-Progress implemented for GUI output (parameter -noConsole) (nesting of progresses is ignored)
- removed unnecessary parameter -runtime30 (there is no such thing as a 3.x runtime)
- if -runtime20 and -runtime40 is supplied together an error message is generated now
- two references to Console removed from -noConsole mode for better stability
Update v0.5.0.2 (2017-01-02):
- STA or MTA mode is used corresponding to the powershell version when not specified (V3 or higher: STA, V2: MTA)
  This prevents problems with COM and some graphic dialogs
- icon file is seeked in the correct directory (thanks to Stuart Dootson)
Update v0.5.0.1 (2016-11-04):
- interfering PROGRESS handler removed

- treats Powershell 5 or above like Powershell 4
- method SetBufferContents for Clear-Host added
- the console output methods do not use black background and white foreground, but use the actual colors now
- new, corrected and much expanded parser for command line parameters
- input and output file are seeked and generated in the correct directory
- check that input file is not the same as the output file
- doubled VERBOSE and WARNING handler removed

Full list of changes and fixes in Changes.txt.



Compile all of the examples in the Examples sub directory with

BuildExamples.bat

Every script will be compiled to a console and a GUI version.


Remarks:

GUI mode output formatting:
Per default output of commands are formatted line per line (as an array of strings). When your command generates 10 lines of output and you use GUI output, 10 message boxes will appear each awaitung for an OK. To prevent this pipe your command to the comandlet Out-String. This will convert the output to a string array with 10 lines, all output will be shown in one message box (for example: dir C:\ | Out-String).

Config files:
PS2EXE create config files with the name of the generated executable + ".config". In most cases those config files are not necessary, they are a manifest that tells which .Net Framework version should be used. As you will usually use the actual .Net Framework, try running your excutable without the config file.

Password security:
Never store passwords in your compiled script! One can simply decompile the script with the parameter -extract. For example
Output.exe -extract:C:\Output.ps1
will decompile the script stored in Output.exe.

Script variables:
Since PS2EXE converts a script to an executable, script related variables are not available anymore. Especially the variable $PSScriptRoot is empty.
The variable $MyInvocation is set to other values than in a script.

You can retrieve the script/executable path independant of compiled/not compiled with the following code (thanks to JacquesFS):

if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript")
{ $ScriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition }
else
{ $ScriptPath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0]) }
