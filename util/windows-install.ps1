Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y python
choco install -y firefox
choco install -y vlc
choco install -y winrar
choco install -y git
choco install -y notepadplusplus
choco install -y foxitreader
choco install -y inkscape
choco install -y putty
choco install -y k-litecodecpackfull
choco install -y slack
choco install -y emacs
choco install -y hunspell.portable
choco install -y msys2

[System.Environment]::SetEnvironmentVariable('Path', "C:\Python310;C:\Python310\Scripts;" + $Env:Path,[System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('PYTHONPATH', 'C:\Python310\Libs',[System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('DICPATH', 'C:\Hunspell',[System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('DICTIONARY', 'en_US',[System.EnvironmentVariableTarget]::Machine)

cd $env:AppData
git clone https://github.com/syl20bnr/spacemacs .emacs.d
