[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$templateRoot = Join-Path $PSScriptRoot '..\project-template'
$templateRoot = (Resolve-Path -LiteralPath $templateRoot).Path

if (-not (Test-Path -LiteralPath $ProjectPath)) {
    New-Item -ItemType Directory -Path $ProjectPath | Out-Null
}

$projectRoot = (Resolve-Path -LiteralPath $ProjectPath).Path
if (-not (Get-Item -LiteralPath $projectRoot).PSIsContainer) {
    throw "ProjectPath is not a directory: $projectRoot"
}

$copied = 0
$skipped = 0

Get-ChildItem -LiteralPath $templateRoot -Recurse -File | ForEach-Object {
    $relativePath = $_.FullName.Substring($templateRoot.Length).TrimStart('\')
    $destination = Join-Path $projectRoot $relativePath
    $destinationDirectory = Split-Path -Parent $destination

    if (-not (Test-Path -LiteralPath $destinationDirectory)) {
        New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
    }

    if ((Test-Path -LiteralPath $destination) -and -not $Force) {
        Write-Warning "Skipped existing file: $destination"
        $skipped++
        return
    }

    Copy-Item -LiteralPath $_.FullName -Destination $destination -Force:$Force
    Write-Host "Copied: $relativePath"
    $copied++
}

$workspaceDirectories = @(
    'docs\workspace\requirements',
    'docs\workspace\designs',
    'docs\workspace\tasks',
    'docs\evidence'
)

foreach ($relativeDirectory in $workspaceDirectories) {
    $directory = Join-Path $projectRoot $relativeDirectory
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }
}

Write-Host "Initialized: $projectRoot"
Write-Host "Copied: $copied; skipped: $skipped"
Write-Host 'Next: fill PROJECT.md, then ask Codex to inspect the repository and update the capability map.'
