如何从Github上获取生产分支？
========================
需要特别注意的是，master通常为开发分支，对于很活跃的项目来说会非常不稳定。
要使用github分发的开源组件，最好使用生产分支，N2O等项目尤其如此。

##从github上获得生产分支的步骤
首先，从github上clone项目：

    # git clone https://github.com/5HT/n2o.git n2o_workspace

然后，使用`git fetch origin [remote-branch]:[new-local-branch]`提取指定分支：

    # git fetch origin 1.8.0:1.8.0
    # git branch
      1.8.0
    * master

最后，切换到生产分支：

    # git checkout 1.8.0
