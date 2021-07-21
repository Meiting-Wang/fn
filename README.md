# Stata 新命令：fn——返回特定文件格式的文件名与所在路径

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 一、引言

我们知道，`dir`也可以返回特定文件格式的文件名，那为何我们还要写`fn`（filenames）命令呢？原因有两点：

- `dir`没有返回值：我们可能在后续需要用到前面所展示的文件名，但由于没有返回值而使得我们无法实现这个想法。
- 我们还可能需要更多的信息，如文件所在的路径、所匹配到的文件的数量。

新写的命令会直接在 Stata 界面上展示文件所在的路径以及匹配到的所有文件名。除此之外，我们还在返回值中存放了以下内容：（1）文件所在的路径；（2）匹配到的所有文件名；（3）匹配文件时所设定的格式；（4）匹配到的文件的数量。

因此，该命令不仅方便用户直接在 Stata 界面上查看匹配信息，而且其返回值的多样性也方便用户将匹配过程中的信息用到后续的命令中。

## 二、命令的安装

`fn`及本人其他命令的代码都托管于 GitHub 上，读者可随时下载安装这些命令。

你可以通过系统自带的`net`命令进行安装：

```stata
net install fn, from("https://raw.githubusercontent.com/Meiting-Wang/fn/main")
```

也可以通过`github`外部命令进行安装（`github`命令本身可以通过`net install github, from("https://haghish.github.io/github/")`进行安装）：

```stata
github install Meiting-Wang/fn
```

## 三、语法与选项

**命令语法**：

```stata
fn ["][filespec]["]
```

> - `filespec`: 输入要找寻的文件名格式，如`*`、`read.tex`、`read*.tex`、`..\*`、`c:\Windows\*.exe`等
> - 命令的使用很简单，更多细节可以`help fn`。

## 四、实例

```stata
fn //展示当前文件夹的所有文件
fn * //展示当前文件夹的所有文件
fn .\mydir\* //展示当前文件夹下子文件夹 "mydir" 中的所有文件
fn ..\* //展示上一级文件夹下的所有文件
fn fn.* //展示当前文件夹符合 "fn.*" 格式的文件
fn *.ado //展示当前文件夹符合 "*.ado" 格式的文件
fn c:\Windows\*.exe //展示 "c:\Windows\" 路径下符合 "*.exe" 格式的文件
fn `c(sysdir_plus)'*.txt //展示 Stata plus 文件夹中符合 "*.txt" 格式的文件
ret list //展示储存在r()中的内容
```

## 五、输出效果展示

```stata
fn c:\Windows\*o*.exe
```

```stata
dirname: c:\Windows\
  files: "explorer.exe" "notepad.exe" "splwow64.exe"
```

```stata
return list
```

```stata
macros:
            r(dirname) : "c:\Windows\"
      r(write_dirname) : "c:\Windows\"
            r(pattern) : "*o*.exe"
          r(files_num) : "3"
              r(files) : ""explorer.exe" "notepad.exe" "splwow64.exe""
```

> 点击【阅读原文】可进入该命令的 github 项目。