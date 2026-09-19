# NanaZip 智能解压

一个轻量的 Windows 包装器，用外部程序调用 NanaZip 的 **提取到当前位置（智能）** 功能。

它适合注册为 `%1` 文件处理器，也适合任何能把文件路径作为第一个参数传入的启动器。

## 实现原理

NanaZip 的智能解压由 Shell 扩展提供。点击资源管理器菜单中的 **提取到当前位置（智能）** 时，NanaZip 实际会以 GUI 程序启动，参数等价于：

```text
NanaZipG.exe x -sps -o"压缩包所在目录" "压缩包路径"
```

`SmartExtract.exe` 做了同样的三件事：

1. 读取 `A_Args[1]` 中的压缩包路径。
2. 使用压缩包所在目录作为输出目录。
3. 启动 `NanaZipG.exe`，参数为 `x -sps -o...`，从而显示 NanaZip 正常的图形化解压进度窗口。

其中 `-sps` 是智能解压开关。必须使用 GUI 版 `NanaZipG.exe`，使用控制台版不会出现同样的图形进度窗口。

## 运行要求

- Windows
- 已安装 NanaZip
- 系统中可以找到 `NanaZipG.exe` 命令别名或可执行文件

包装器会依次检查以下位置：

```text
%LOCALAPPDATA%\Microsoft\WindowsApps\NanaZipG.exe
%APPDATA%\Microsoft\WindowsApps\NanaZipG.exe
%ProgramFiles%\NanaZip\NanaZipG.exe
%ProgramFiles%\NanaZip\NanaZip.Universal.Windows.exe
%ProgramFiles(x86)%\NanaZip\NanaZipG.exe
%ProgramFiles(x86)%\NanaZip\NanaZip.Universal.Windows.exe
```

## 下载

请从最新 GitHub Release 下载 `SmartExtract.exe`：

```text
https://github.com/Kano-u/nanazip-smart-extract/releases/latest
```

编译产物作为 Release 附件发布，不提交到源码仓库。

## 用法

把压缩包路径作为第一个参数运行：

```cmd
SmartExtract.exe "D:\Downloads\example.7z"
```

路径包含空格时同样使用引号：

```cmd
SmartExtract.exe "D:\My Downloads\CapsWriter-Offline.7z"
```

注册为文件关联或右键菜单命令时使用：

```text
"SmartExtract.exe" "%1"
```

程序会把压缩包解压到它所在目录。输出遵循 NanaZip 的智能解压规则：

- 压缩包只有一个顶层项目时，直接解压该项目。
- 压缩包有多个顶层项目时，自动创建以压缩包名称命名的文件夹。

解压期间会打开 NanaZip 图形化进度窗口。

## 构建

源码为 `SmartExtract.ahk`，基于 AutoHotkey v2。

使用 `Ahk2Exe` 编译：

```cmd
Ahk2Exe.exe /in "SmartExtract.ahk" /out "SmartExtract.exe" /base "AutoHotkey64.exe"
```

编译完成后，把 `SmartExtract.exe` 作为 GitHub Release 附件上传。

## 说明

本项目不包含 NanaZip 源码，只依赖本机安装的 NanaZip GUI 程序，并使用其公开的命令行参数。
