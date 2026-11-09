$postman = Get-ChildItem "$env:LOCALAPPDATA\Postman\app-*" -Filter "Postman.exe" -Recurse |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if ($postman) {
    Remove-NetFirewallRule -DisplayName "Postman" -ErrorAction SilentlyContinue
    New-NetFirewallRule -DisplayName "Postman" -Direction Inbound -Program $postman.FullName -Action Allow -Profile Any
}