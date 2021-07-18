* Description: fn means filenames, to return the name and path of the specified files
* Author: Meiting Wang, doctor, Institute for Economic and Social Research, Jinan University
* Email: wangmeiting92@gmail.com
* Created on July 17, 2021



program define fn, rclass
version 16.0

syntax anything(id="Filenames format setting")

*----------------前期程序-------------------
*初步提取dirname和pattern
local anything = ustrregexra(`"`anything'"',`"(^"\s*)|(\s*"$)"',"") //去除anything中的双引号和前端和末尾多余的空格

if ~ustrregexm("`anything'","(/)|(\\)") {
	local dirname "."
	local pattern "`anything'"
}
else if ustrregexm("`anything'","^([^/\\].*[/\\])([^/\\]+)$") {
	local dirname = ustrregexs(1)
	local pattern = ustrregexs(2)
}
else {
	dis "{error:fn syntax error}"
	error 9999
}

*具体化 dirname
if ustrregexm("`dirname'","(^\.\.)(.*)") {
	local temp1 = ustrregexs(2)
	local temp2 = ustrregexra(`"`c(pwd)'"',"\\[^\\]+$","")
	local dirname `"`temp2'`temp1'"'
} //这里的dirname最后一定带有/或\
else if ustrregexm("`dirname'","(^\.)(.*)") {
	local temp1 = ustrregexs(2)
	local dirname `"`c(pwd)'`temp1'"'
} //这里的dirname最后可能存在也可能不存在/或\

if ustrregexm(`"`dirname'"',"^.*[^/\\]$") {
	local dirname `"`dirname'\"'
} //以保证dirname最后一定有\或/



*-------------------主程序--------------------------
local list: dir `"`dirname'"' files `"`pattern'"', respectcase



*---------------------结果的输出与返回值----------------------
dis _n as text `"dirname: {result:`dirname'}"'
dis as text `"pattern: {result:`pattern'}"'
if `"`list'"' != "" {
	dis as text `"  files: {result:`list'}"'
}
else {
	dis as text `"  files: {result:No files found}"'
}

return local files `"`list'"'
return local pattern `"`pattern'"'
return local dirname `"`dirname'"'

end
