cls
cd X:\exercise\Stata\fn
pr drop _all

fn * //展示当前文件夹的所有文件
fn .\mydir\* //展示当前文件夹下子文件夹 "mydir" 中的所有文件
fn ..\* //展示上一级文件夹下的所有文件
fn fn.* //展示当前文件夹符合 "fn.*" 格式的文件
fn *.ado //展示当前文件夹符合 "*.ado" 格式的文件
fn c:\Windows\*.exe //展示 "c:\Windows\" 路径下符合 "*.exe" 格式的文件
fn `c(sysdir_plus)'*.txt //展示 Stata plus 文件夹中符合 "*.txt" 格式的文件
ret list //展示储存在r()中的内容
