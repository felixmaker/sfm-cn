if(Test-Path .\bucket) {
    Remove-Item -Path .\bucket -Recurse -Force
}

New-Item -ItemType "directory" -Path ".\bucket"

Copy-Item -Path ".\scoop-felixmaker\bucket\*" -Destination ".\bucket" -Recurse -Force
Remove-Item -Path .\scoop-felixmaker -Recurse -Force

Get-ChildItem -Recurse -Path .\bucket | ForEach-Object -Process {
    # GitHub Releases
    (Get-Content $_.FullName) -replace '(github\.com/.+/releases/download)', 'gh-proxy.com/https://$1' | Set-Content -Path $_.FullName

    # GitHub Raw
    (Get-Content $_.FullName) -replace '(raw\.githubusercontent\.com)', 'gh-proxy.com/https://$1' | Set-Content -Path $_.FullName
    (Get-Content $_.FullName) -replace '(github\.com/.+/raw)', 'gh-proxy.com/https://$1' | Set-Content -Path $_.FullName
}
