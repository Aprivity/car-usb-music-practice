# 车载 U 盘音乐整理与格式转换实践

一个面向老款车机的 U 盘音乐整理实践项目。项目目标是把本地音乐整理成车机更容易识别、稳定播放、方便后续维护的格式和目录结构。

## 核心结论

对于 2016 年左右的尼桑轩逸等老款车机，推荐方案是：

```text
U盘格式：FAT32
U盘容量：16GB / 32GB 优先
音乐格式：MP3
码率：320kbps
采样率：44.1kHz
声道：双声道
目录结构：根目录或 MUSIC 一级文件夹
文件命名：001 歌名.mp3
```

这个项目的重点不是追求最高音质，而是解决车载播放中的兼容性、识别稳定性、文件排序和后续维护问题。

## 项目结构

```text
car-usb-music-practice
├── README.md
├── .gitignore
├── docs
│   ├── practice-summary.md
│   ├── usage-guide.md
│   └── roadmap.md
├── examples
│   └── folder-structure.txt
└── scripts
    └── flac_to_mp3.ps1
```

## 快速开始

### 1. 准备 U 盘

优先使用 16GB 或 32GB U 盘，并格式化为 FAT32。

### 2. 安装 FFmpeg

在 PowerShell 中执行：

```powershell
winget install -e --id Gyan.FFmpeg
```

安装完成后，关闭当前 PowerShell，重新打开，再验证：

```powershell
ffmpeg -version
```

### 3. 批量转换 FLAC 为 MP3

把需要转换的 FLAC 文件放在同一文件夹中，然后执行：

```powershell
./scripts/flac_to_mp3.ps1 -InputDir "D:\Music\flac" -OutputDir "D:\Music\mp3"
```

默认输出规格：

```text
MP3 / 320kbps / 44.1kHz / 双声道
```

### 4. 整理到 U 盘

推荐结构一：兼容性最强。

```text
U盘
├── 001 晴天.mp3
├── 002 夜曲.mp3
├── 003 稻香.mp3
└── 004 江南.mp3
```

推荐结构二：更整洁。

```text
U盘
└── MUSIC
    ├── 001 晴天.mp3
    ├── 002 夜曲.mp3
    ├── 003 稻香.mp3
    └── 004 江南.mp3
```

不建议使用过深目录，例如“音乐/华语/歌手/专辑/歌曲.mp3”，老车机可能无法完整扫描。

## 文档索引

- [实践总结](docs/practice-summary.md)
- [使用指南](docs/usage-guide.md)
- [后续路线图](docs/roadmap.md)
- [目录结构示例](examples/folder-structure.txt)

## Git 管理建议

本仓库只保存脚本、文档、示例结构，不保存真实音乐文件。

已在 `.gitignore` 中排除：

```text
*.mp3
*.flac
*.wav
*.ape
*.ncm
*.m4a
*.lrc
mp3/
output/
converted/
```

这样可以避免把本地音乐文件误提交到 GitHub。

## 项目定位

这是一个生活场景驱动的小型技术实践项目，体现完整的问题解决流程：

```text
真实需求 → 问题分析 → 工具选型 → 实际操作 → 问题排查 → 文档沉淀
```

它适合放入个人项目体系中，作为“工具使用能力、文档整理能力、实践闭环能力”的展示案例。
