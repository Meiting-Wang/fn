#!/bin/bash
###################create public repository##################


#------------用户修改部分------------------
REPO_NAME="fn"
PRIVATE="false"
REPO_DESCRIPTION="[W-13] Return the name and path of the specified files."


#-------------无需修改部分------------------
USER_NAME="Meiting-Wang"
TOKEN="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"

#本地 repository 初始化
git init #默认创建master分支
git checkout -b main #创建并进入main分支(此时本地的master分支直接消失)
git add .

if [ "$1" ]
then
    git commit -m "$1"
else
    git commit -m "first commit"
fi


#创建 github 远端 repo
curl -H "Authorization: token ${TOKEN}" \
    -d "{\"name\":        \"${REPO_NAME}\", \
         \"private\":       ${PRIVATE}, \
         \"description\": \"${REPO_DESCRIPTION}\" \
     }" \
     https://api.github.com/user/repos 

#关联本地仓库与远端仓库，并将本地仓库推送至远端仓库
git remote add origin git@github.com:${USER_NAME}/${REPO_NAME}.git #关联远端仓库与本地仓库
git push -u origin main #-u参数表示之后的推送可直接由 git push 完成