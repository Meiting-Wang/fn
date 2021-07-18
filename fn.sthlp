{smcl}
{right:Updated time: July 17, 2021}
{* -----------------------------title------------------------------------ *}{...}
{p 0 16 2}
{bf:[W-13] fn} {hline 2} Return the name and path of the specified files. You can view the source code in {browse "https://github.com/Meiting-Wang/fn":github}.


{* -----------------------------Syntax------------------------------------ *}{...}
{title:Syntax}

{p 8 8 2}
{cmd:fn} ["][{it:filespec}]["]


{* -----------------------------Contents------------------------------------ *}{...}
{title:Contents}

{p 4 4 2}
{help fn##Description:Description}{break}
{help fn##Examples:Examples}{break}
{help fn##Author:Author}{break}
{help fn##Also_see:Also see}{break}


{* -----------------------------Description------------------------------------ *}{...}
{marker Description}{title:Description}

{p 4 4 2}{cmd:fn} means "filenames" and can return the name and path of the specified files.{p_end}

{p 4 4 2}{cmd:fn} is equivalent to an extended version of {help dir}. In other words, {cmd:fn} can return the file name and its path, and can store the stuffs above in {bf:r()} for later programming use, while {help dir} can only return the file name on the Stata interface.{p_end}

{p 4 4 2}It is worth noting that this command can only be used in version 16.0 or later.{p_end}


{* -----------------------------Examples------------------------------------ *}{...}
{marker Examples}{title:Examples}

{p 4 4 2}Show all files in the current folder{p_end}
{p 8 8 2}. {stata fn *}{p_end}

{p 4 4 2}Show all files in the subfolder {bf:"mydir"} under the current folder{p_end}
{p 8 8 2}. {stata fn .\mydir\*}{p_end}

{p 4 4 2}Show all files in the upper level folder{p_end}
{p 8 8 2}. {stata fn ..\*}{p_end}

{p 4 4 2}Show the files in the current folder that conform to the {bf:"fn.*"} format{p_end}
{p 8 8 2}. {stata fn fn.*}{p_end}

{p 4 4 2}Show the files in the current folder that conform to the {bf:"*.ado"} format{p_end}
{p 8 8 2}. {stata fn *.ado}{p_end}

{p 4 4 2}Show the files in the {bf:"c:\Windows\"} path that conform to the {bf:"*.exe"} format{p_end}
{p 8 8 2}. {stata `"fn c:\Windows\*.exe"'}{p_end}

{p 4 4 2}Show the files in the Stata plus folder that conform to the {bf:"*.txt"} format{p_end}
{p 8 8 2}. {stata fn `c(sysdir_plus)'*.txt}{p_end}

{p 4 4 2}Show the content stored in {bf:r()}{p_end}
{p 8 8 2}. {stata fn *.ado}{p_end}
{p 8 8 2}. {stata return list}{p_end}


{* -----------------------------Author------------------------------------ *}{...}
{marker Author}{title:Author}

{p 4 4 2}
Meiting Wang{break}
Institute for Economic and Social Research, Jinan University{break}
Guangzhou, China{break}
wangmeiting92@gmail.com


{* -----------------------------Also see------------------------------------ *}{...}
{marker Also_see}{title:Also see}

{space 4}{help dir}

