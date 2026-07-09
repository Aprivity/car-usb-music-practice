# flac_to_mp3.ps1
# 功能：将当前文件夹下的 .flac 文件批量转换为 320kbps MP3
# 适用场景：车载 U 盘音乐整理
# 前置要求：已安装 FFmpeg，并能在 PowerShell 中直接运行 ffmpeg 命令

$ErrorActionPreference = "Stop"

Write-Host "开始检查 FFmpeg 环境..." -ForegroundColor Cyan

try {
    ffmpeg -version | Out-Null
    Write-Host "FFmpeg 检测成功。" -ForegroundColor Green
}
catch {
    Write-Host "未检测到 FFmpeg，请先安装 FFmpeg。" -ForegroundColor Red
    Write-Host "推荐安装命令：winget install -e --id Gyan.FFmpeg" -ForegroundColor Yellow
    exit 1
}

$outputDir = "mp3"

if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$flacFiles = Get-ChildItem -Path . -Filter *.flac

if ($flacFiles.Count -eq 0) {
    Write-Host "当前文件夹未找到 FLAC 文件。" -ForegroundColor Yellow
    exit 0
}

Write-Host "共找到 $($flacFiles.Count) 个 FLAC 文件，开始转换..." -ForegroundColor Cyan

foreach ($file in $flacFiles) {
    $inputPath = $file.FullName
    $outputPath = Join-Path $outputDir ($file.BaseName + ".mp3")

    Write-Host "正在转换：$($file.Name)" -ForegroundColor Cyan

    ffmpeg -y -i "$inputPath" -codec:a libmp3lame -b:a 320k -ar 44100 -ac 2 "$outputPath"
}

Write-Host "全部转换完成，输出目录：$outputDir" -ForegroundColor Green
