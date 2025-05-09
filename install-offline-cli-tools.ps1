# PowerShell 脚本：全局安装 offline-cli-tools 下所有 .tgz 包

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$toolsDir = Join-Path $scriptDir "offline-cli-tools"

try {
    Set-Location $toolsDir

    Get-ChildItem -Filter *.tgz | ForEach-Object {
        Write-Host "正在全局安装 $($_.Name) ..."
        npm install -g $_.FullName
    }

    Set-Location $scriptDir
    Write-Host "所有离线 CLI 工具已全局安装完成。"
}
catch {
    Write-Host "安装过程中发生错误！"
}
finally {
    Write-Host ""
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}