$ErrorActionPreference = "Stop"

$RootDir = Resolve-Path (Join-Path $PSScriptRoot "..")
$VendorDir = Join-Path $RootDir "vendor"
New-Item -ItemType Directory -Force -Path $VendorDir | Out-Null

$Dependencies = @(
  @{
    Name = "xlsx"
    Url = "https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"
    File = "xlsx.full.min.js"
  },
  @{
    Name = "canvas-confetti"
    Url = "https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.3/dist/confetti.browser.min.js"
    File = "confetti.browser.min.js"
  },
  @{
    Name = "three"
    Url = "https://cdn.jsdelivr.net/npm/three@0.146.0/build/three.min.js"
    File = "three.min.js"
  },
  @{
    Name = "three-trackball-controls"
    Url = "https://cdn.jsdelivr.net/npm/three@0.146.0/examples/js/controls/TrackballControls.js"
    File = "TrackballControls.js"
  },
  @{
    Name = "three-css3d-renderer"
    Url = "https://cdn.jsdelivr.net/npm/three@0.146.0/examples/js/renderers/CSS3DRenderer.js"
    File = "CSS3DRenderer.js"
  },
  @{
    Name = "tweenjs"
    Url = "https://cdn.jsdelivr.net/npm/@tweenjs/tween.js@18.6.4/dist/tween.umd.js"
    File = "tween.umd.js"
  }
)

foreach ($Dependency in $Dependencies) {
  $Target = Join-Path $VendorDir $Dependency.File
  Write-Host "Downloading $($Dependency.Name) -> vendor/$($Dependency.File)"
  Invoke-WebRequest -Uri $Dependency.Url -OutFile $Target -UseBasicParsing

  $DownloadedFile = Get-Item $Target
  if ($DownloadedFile.Length -le 0) {
    throw "Downloaded file is empty: $Target"
  }
}

Write-Host "Done. Vendor scripts are ready in: $VendorDir"
