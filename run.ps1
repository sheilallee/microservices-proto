param(
    [ValidateSet("order", "payment")]
    [string]$ServiceName = "order"
)

$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$GoPath = (go env GOPATH)
$PluginBin = Join-Path $GoPath "bin"

Write-Host "Installing protoc plugins..."
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

if (-not ($env:Path -split ";" | Where-Object { $_ -eq $PluginBin })) {
    $env:Path = "$env:Path;$PluginBin"
}

Write-Host "Generating Go stubs for '$ServiceName'..."
Push-Location $ProjectRoot
New-Item -ItemType Directory -Path "golang" -Force | Out-Null

protoc --proto_path=. `
  --go_out=./golang `
  --go_opt=paths=source_relative `
  --go-grpc_out=./golang `
  --go-grpc_opt=paths=source_relative `
  ./$ServiceName/*.proto

$OutDir = Join-Path $ProjectRoot "golang/$ServiceName"
Push-Location $OutDir
if (-not (Test-Path "go.mod")) {
    go mod init "github.com/sheilallee/microservices-proto/golang/$ServiceName"
}
go mod tidy
Pop-Location
Pop-Location

Write-Host "Stubs generated successfully at golang/$ServiceName"
