# 删除已有的文件
Remove-Item -Path .\bucket -Recurse -Force

# 将克隆的最新的文件拷贝到待处理的文件夹
New-Item -ItemType "directory" -Path ".\bucket"

# 仓库
Copy-Item -Path ".\scoop-felixmaker\bucket\*" -Destination ".\bucket" -Recurse -Force

# 复制完后，删掉克隆的文件夹
Remove-Item -Path .\scoop-felixmaker -Recurse -Force

Get-ChildItem -Recurse -Path .\bucket | ForEach-Object -Process {
    # GitHub Releases
    (Get-Content $_.FullName) -replace '(github\.com/.+/releases/download)', 'ghproxy.com/https://$1' | Set-Content -Path $_.FullName

    # GitHub Raw
    (Get-Content $_.FullName) -replace '(raw\.githubusercontent\.com)', 'ghproxy.com/https://$1' | Set-Content -Path $_.FullName
    (Get-Content $_.FullName) -replace '(github\.com/.+/raw)', 'ghproxy.com/https://$1' | Set-Content -Path $_.FullName
}
