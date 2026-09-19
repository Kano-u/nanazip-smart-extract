# NanaZip Smart Extract

A lightweight Windows wrapper that performs NanaZip's **Extract Here (Smart)** action from another program.

It is intended for use as a `%1` file handler or from any launcher that can run a command with the archive path as the first argument.

## How It Works

NanaZip exposes Smart Extraction through its shell extension. When the Explorer menu item **Extract Here (Smart)** is selected, NanaZip launches its GUI program with this equivalent command line:

```text
NanaZipG.exe x -sps -o"archive-directory" "archive-path"
```

`SmartExtract.exe` does the same three things:

1. Reads the archive path from `A_Args[1]`.
2. Uses the archive's containing directory as the output directory.
3. Starts `NanaZipG.exe` with `x -sps -o...`, which displays the normal NanaZip extraction progress GUI.

The `-sps` switch enables Smart Extraction. `NanaZipG.exe` is the GUI build; using the console build would not provide the same GUI progress window.

## Requirements

- Windows
- NanaZip installed
- The `NanaZipG.exe` command alias or executable available in one of the supported locations

The wrapper checks these locations:

```text
%LOCALAPPDATA%\Microsoft\WindowsApps\NanaZipG.exe
%APPDATA%\Microsoft\WindowsApps\NanaZipG.exe
%ProgramFiles%\NanaZip\NanaZipG.exe
%ProgramFiles%\NanaZip\NanaZip.Universal.Windows.exe
%ProgramFiles(x86)%\NanaZip\NanaZipG.exe
%ProgramFiles(x86)%\NanaZip\NanaZip.Universal.Windows.exe
```

## Download

Download `SmartExtract.exe` from the latest GitHub Release:

```text
https://github.com/Kano-u/nanazip-smart-extract/releases/latest
```

## Usage

Run the executable with the archive path as its first argument:

```cmd
SmartExtract.exe "D:\Downloads\example.7z"
```

Example with a path containing spaces:

```cmd
SmartExtract.exe "D:\My Downloads\CapsWriter-Offline.7z"
```

When registered as a file association or context-menu command, use:

```text
"SmartExtract.exe" "%1"
```

The archive is extracted to its own directory. The output follows Smart Extraction rules:

- If the archive has one root item, that item is extracted directly.
- If the archive has multiple root items, NanaZip creates a folder named after the archive.

NanaZip opens its GUI progress window while extraction is running.

## Build

The source is `SmartExtract.ahk`, written for AutoHotkey v2.

Compile it with `Ahk2Exe`:

```cmd
Ahk2Exe.exe /in "SmartExtract.ahk" /out "SmartExtract.exe" /base "AutoHotkey64.exe"
```

The compiled executable is published as a GitHub Release asset. It is not committed to the source tree.

## Notes

This project does not include NanaZip source code. It relies on an installed NanaZip GUI program and uses NanaZip's public command-line switches.
