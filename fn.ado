* Description: fn means filenames, to return the name and path of the specified files
* Author: Meiting Wang, doctor, Institute for Economic and Social Research, Jinan University
* Email: wangmeiting92@gmail.com
* Created on July 17, 2021
* Updated on July 26, 2021



program define fn, rclass
version 16.0

syntax [anything(id="Filenames format setting")]


*----------------前期程序------------------
*初步提取dirname和pattern
if `"`anything'"' == "" {
	local anything "*"
} //如果 anything 为空，则默认报告当前文件夹下的所有文件

local anything = ustrregexra(`"`anything'"',`"(^"\s*)|(\s*"$)"',"") //去除anything中的双引号和前端和末尾多余的空格

if ~ustrregexm("`anything'","(/)|(\\)") {
	local dirname ".\"
	local write_dirname ""
	local pattern "`anything'"
}
else if ustrregexm("`anything'","^([^/\\].*[/\\])([^/\\]+)$") {
	local dirname = ustrregexs(1) //最后带有/或\
	local write_dirname = ustrregexs(1) //最后带有/或\
	local pattern = ustrregexs(2)
}
else {
	dis "{error:fn syntax error}"
	error 9999
}

*具体化 dirname
if ustrregexm("`dirname'","(^\.\.)([/\\].*)") { //输入时 .. 开头的必定是以 ../ 或 ..\ 开头
	local temp1 = ustrregexs(2)
	local temp2 = ustrregexra(`"`c(pwd)'"',"\\[^\\]+$","")
	local dirname `"`temp2'`temp1'"'
} //这里的 dirname 最后带有/或\
else if ustrregexm("`dirname'","(^\.)([/\\].*)") {
	local temp1 = ustrregexs(2)
	local dirname `"`c(pwd)'`temp1'"'
} //这里的 dirname 最后带有/或\


*-------------------主程序--------------------------
local filenames: dir `"`dirname'"' files `"`pattern'"', respectcase
local files_num = ustrlen(ustrregexra(`"`filenames'"',`"[^"]"',"")) / 2 //文件名的数量


*---------------------结果的输出与返回值----------------------
if `"`filenames'"' != "" {
	dis _n as text `"files: {result:`filenames'}"'
}
else {
	dis _n as text `"files: {result:No files found}"'
}

dis as text `"dirname: {result:`dirname'}"'


return local write_dirname `"`write_dirname'"'
return local dirname `"`dirname'"'
return local pattern `"`pattern'"'
return local files_num `"`files_num'"'
return local files `"`filenames'"'

end
