#Requires AutoHotkey v2.0

if A_Args.Length < 1
{
    MsgBox "Usage: SmartExtract.ahk `"archive`"", "NanaZip Smart Extract", 16
    ExitApp 2
}

archivePath := A_Args[1]
if archivePath = ""
{
    MsgBox "Usage: SmartExtract.ahk `"archive`"", "NanaZip Smart Extract", 16
    ExitApp 2
}

SplitPath archivePath, , &archiveDir
if archiveDir = ""
    archiveDir := A_WorkingDir
else
    archiveDir := RTrim(archiveDir, "\")
if SubStr(archiveDir, -1) = ":"
    archiveDir := archiveDir "\"

nanaZipGui := FindNanaZipGui()
if nanaZipGui = ""
{
    MsgBox "NanaZip GUI (NanaZipG.exe) was not found.", "NanaZip Smart Extract", 16
    ExitApp 3
}

commandLine := '"' nanaZipGui '" x -sps -o"' archiveDir '" "' archivePath '"'
Run commandLine, archiveDir
ExitApp 0

FindNanaZipGui()
{
    candidates := []
    candidates.Push(EnvGet("LOCALAPPDATA") "\Microsoft\WindowsApps\NanaZipG.exe")
    candidates.Push(EnvGet("APPDATA") "\Microsoft\WindowsApps\NanaZipG.exe")
    candidates.Push(EnvGet("ProgramFiles") "\NanaZip\NanaZipG.exe")
    candidates.Push(EnvGet("ProgramFiles") "\NanaZip\NanaZip.Universal.Windows.exe")
    candidates.Push(EnvGet("ProgramFiles(x86)") "\NanaZip\NanaZipG.exe")
    candidates.Push(EnvGet("ProgramFiles(x86)") "\NanaZip\NanaZip.Universal.Windows.exe")

    for candidate in candidates
    {
        if candidate != "" && FileExist(candidate)
            return candidate
    }

    return ""
}
