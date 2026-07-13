param(
  [Parameter(Mandatory = $true)]
  [string]$ProjectRoot
)

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $here
$skillsSrc = Join-Path $repoRoot 'skills\engineering'
$dest = Join-Path $ProjectRoot '.afn\skills'

if (-not (Test-Path $ProjectRoot)) {
  Write-Error "No existe ProjectRoot: $ProjectRoot"
}

New-Item -ItemType Directory -Force -Path $dest | Out-Null

$packs = @('afn-spec-es', 'afn-spec-impl-es')
foreach ($id in $packs) {
  $skillMd = Join-Path $skillsSrc "$id\SKILL.md"
  if (-not (Test-Path $skillMd)) {
    Write-Error "Falta $skillMd"
  }
  $body = Get-Content -Raw -Encoding UTF8 $skillMd
  $name = if ($id -eq 'afn-spec-es') { 'Especificación SDD (ES)' } else { 'Implementar spec aprobado (ES)' }
  $json = @{
    id          = $id
    name        = $name
    description = ($body -split "`n" | Select-Object -First 5 | Out-String).Trim()
    content     = $body
    tags        = @('sdd', 'develop', 'plan', 'afn', 'es')
  } | ConvertTo-Json -Depth 4
  $outFile = Join-Path $dest "skill_$id.json"
  Set-Content -Path $outFile -Value $json -Encoding UTF8
  Write-Host "OK $outFile"
}

Write-Host "Skills instalados en $dest"
