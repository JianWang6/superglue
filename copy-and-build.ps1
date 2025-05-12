# PowerShell script to copy the project and run npm install and turbo run

# Define the source and destination directories
$sourceDir = (Get-Location).Path  # Set the source directory to the current root directory

# 生成以当前日期和时间（精确到秒）命名的目标目录
$baseDestinationDir = "D:\WebOIS\Build"
$dateTimeStr = Get-Date -Format "yyyyMMdd_HHmmss"
$destinationDir = Join-Path $baseDestinationDir $dateTimeStr


# 创建目标目录（包含日期时间）
if (-Not (Test-Path -Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}


# 使用 robocopy 排除 packages\web、.turbo、.git、node_modules、.cursor 目录，其它全部拷贝
$excludeDirs = @(
    "packages\web",
    ".turbo",
    ".git",
    "node_modules",
    ".cursor"
)

# 构建 /XD 参数数组
$xdArgs = $excludeDirs | ForEach-Object { "/XD", "$sourceDir\$_" }
robocopy $sourceDir $destinationDir /E @xdArgs

# Change to the destination directory
Set-Location -Path $destinationDir

# Run npm install
npm install

# Run turbo run
turbo run dev