# flac_to_mp3.ps1
# 功能：将 FLAC 文件批量转换为 320kbps MP3
# 适用场景：车载 U 盘音乐整理
# 前置要求：已安装 FFmpeg，并能在 PowerShell 中直接运行 ffmpeg 命令

param(
    [string]$InputDir = ".",
    [string]$OutputDir = "mp3",
    [string]$Bitrate = "320k",
    [switch]$Recurse
)

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

if (!(Test-Path $InputDir)) {
    Write-Host "输入目录不存在：$InputDir" -ForegroundColor Red
    exit 1
}

if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

if ($Recurse) {
    $flacFiles = Get-ChildItem -Path $InputDir -Filter *.flac -File -Recurse
}
else {
    $flacFiles = Get-ChildItem -Path $InputDir -Filter *.flac -File
}

if ($flacFiles.Count -eq 0) {
    Write-Host "未找到 FLAC 文件：$InputDir" -ForegroundColor Yellow
    exit 0
}

Write-Host "共找到 $($flacFiles.Count) 个 FLAC 文件，开始转换..." -ForegroundColor Cyan
Write-Host "输出目录：$OutputDir" -ForegroundColor Cyan
Write-Host "码率：$Bitrate" -ForegroundColor Cyan

$successCount = 0
$failCount = 0

foreach ($file in $flacFiles) {
    $outputPath = Join-Path $OutputDir ($file.BaseName + ".mp3")

    Write-Host "正在转换：$($file.Name)" -ForegroundColor Cyan

    try {
        ffmpeg -y -i "$($file.FullName)" -codec:a libmp3lame -b:a $Bitrate -ar 44100 -ac 2 "$outputPath"
        $successCount++
    }
    catch {
        Write-Host "转换失败：$($file.Name)" -ForegroundColor Red
        $failCount++
    }
}

Write-Host "转换完成。" -ForegroundColor Green
Write-Host "成功：$successCount" -ForegroundColor Green
Write-Host "失败：$failCount" -ForegroundColor Yellow
Write-Host "输出目录：$OutputDir" -ForegroundColor Green
