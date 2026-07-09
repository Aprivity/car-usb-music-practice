# 使用指南

## 1. 安装 FFmpeg

在 PowerShell 中执行：

```powershell
winget install -e --id Gyan.FFmpeg
```

安装完成后，关闭当前 PowerShell，重新打开，再输入：

```powershell
ffmpeg -version
```

如果能看到版本信息，说明 FFmpeg 安装成功。

## 2. 转换 FLAC 为 MP3

推荐在仓库根目录执行：

```powershell
./scripts/flac_to_mp3.ps1 -InputDir "D:\Music\flac" -OutputDir "D:\Music\mp3"
```

也可以进入 FLAC 文件所在目录后执行：

```powershell
./flac_to_mp3.ps1
```

脚本默认会输出到当前目录下的 `mp3` 文件夹。

## 3. 常用参数

```powershell
./scripts/flac_to_mp3.ps1 `
  -InputDir "D:\Music\flac" `
  -OutputDir "D:\Music\mp3" `
  -Bitrate "320k"
```

递归处理子文件夹：

```powershell
./scripts/flac_to_mp3.ps1 -InputDir "D:\Music\flac" -OutputDir "D:\Music\mp3" -Recurse
```

## 4. FFmpeg 无法识别怎么办

如果 PowerShell 提示：

```text
ffmpeg : 无法将“ffmpeg”项识别为 cmdlet、函数、脚本文件或可运行程序的名称。
```

常见原因包括：

1. FFmpeg 没有安装；
2. FFmpeg 没有加入系统环境变量 PATH；
3. 安装后没有重新打开 PowerShell。

优先重新打开 PowerShell 后执行：

```powershell
ffmpeg -version
```

仍然失败时，重新安装：

```powershell
winget install -e --id Gyan.FFmpeg
```

## 5. U 盘文件命名建议

推荐：

```text
001 歌名.mp3
002 歌名.mp3
003 歌名.mp3
```

或：

```text
001 - 歌手 - 歌名.mp3
002 - 歌手 - 歌名.mp3
003 - 歌手 - 歌名.mp3
```

尽量避免：

- 文件名过长；
- 特殊符号过多；
- 中英文、emoji、奇怪符号混杂；
- 过深目录层级。
