Emacs速查手册
============

Emacs24.3, MacOS 10.9.5

homeway.xue@gmail.com, 2014年9月25日

* [环境配置](#环境配置)
* [基础概念](#基础概念)
* [基本命令](#基本命令)
* [副模式命令](#副模式命令)
* [文件操作命令](#文件操作命令)
* [光标移动命令](#光标移动命令)
* [文本删除命令](#文本删除命令)
* [文本块常用操作步骤](#文本块常用操作步骤)
* [文本块操作命令](#文本块操作命令)
* [段落重排](#段落重排)
* [编辑技巧](#编辑技巧)
* [递增查找命令](#递增查找命令)
* [查找－替换操作](#查找－替换操作)
* [窗口命令](#窗口命令)
* [缓冲区命令](#缓冲区命令)
* [书签](#书签)
* [Shell交互](#Shell交互)

环境配置
--------
Emacs启动时会寻找主目录的~/.emacs配置文件，大部分插件都需要在此文件中配置。

###基本定制
    ;; 去掉菜单
    (menu-bar-mode -1)
    ;; 显示代码的行号
	;; 若需要临时显示，可使用M-x linum-mode 切换
    (global-linum-mode 1)

###包管理器安装
	;;启用包管理
    (require 'package)
    (add-to-list 'package-archives
	             '("melpa" . "http://melpa.milkbox.net/packages/") t)
    (package-initialize)
####更新包内容
`M-x package-refresh-contents RET`

###安装solarized主题
参考[github/emacs-color-theme-solarized](https://github.com/sellout/emacs-color-theme-solarized)

将emacs-color-theme-solarized目录加入到Emacs的custom-theme-load-path，或从包管理器安装：

    package-install color-theme-solarized

再将下面一行增加到初始化文件中：

    (load-theme 'solarized-[light|dark] t)

重新加载初始化文件，或重启Emacs。

###magit
参考[github/magit](https://github.com/magit/magit)或[magit手册](http://magit.github.io/master/magit.html)。

M-x package-install 安装命令：`M-x package-install RET magit RET`

* M-x magit-status - 执行`git status`并进入magit操作主界面（配合`projectile`可以使用快捷键`C-c p v`）
*  ?               - 帮助
*  q               - 退出
*  s               - stage
*  i               - ignore
*  l               - 进入日志选项
*  c               - 进入commit选项
*    C-c C-c       - 提交

###Erlang模式
[Erlang模式](http://www.erlang.org/doc/apps/tools/erlang_mode_chapter.html)内置于OTP发行版中。
命令`M-x erlang-mode RET`可将当前缓冲区切换为Erlang主模式。
正确安装erlang模式后，编辑.erl或.hrl文档时会自动切换到该主模式。

详细的配置说明在[erlang模式手册](http://www.erlang.org/doc/man/erlang.el.html)。

####安装和配置
	;; erlang模式
	;; 设置自动模板中的邮箱
	(setq user-mail-address "homeway.xue@gmail.com")
	(setq load-path (cons "~/erlang/erts/r17/lib/tools-2.6.14/emacs/" load-path))
	(setq erlang-root-dir "~/erlang/erts/r17")
	(setq exec-path (cons "~/erlang/erts/r17/bin/" exec-path))
	;; 一个不错的初始化配置
	(require 'erlang-start) 

这个配置中使用的erlang是通过kerl配置的，通过kerl编译并安装了erlang之后，在shell启动文件中增加了如下配置行：

	# start erlang with kerl
	. /Users/homeway/erlang/erts/r17/activate                                             

####注释
* C-c C-c 将标记区域注释
* C-u 3 C-c C-c 使用%%%标记注释
* C-c C-u 取消注释

####编辑函数子句
* C-c C-j 生成新的函数子句
* C-c C-y 拷贝函数子句的参数

####模板
命令系列：`tempo...`

* 简单模板 - If, Case, Receive, Receive After, Receive Loop
* 源文件头 - Module, Author, Small Header, Normal Header, Large Header
* Small Server - 不带OTP的Server模板
* Application - OTP application
* Supervisor - OTP supervisor
* Superbisor Brigge - OTP supervisor bridge
* gen_server - OTP gen_server
* gen_event - OTP gen_event
* gen_fsm - OTP gen_fsm
* Library模块 - 不实现进程的模块
* Corba回调 - Corba回调模块
* Erlang test suite - OTP测试模块生成

####Shell
    erlang-shell - 启动新的shell
    C-c C-z      - 显示Erlang shell（如果不存在就新建一个）
    C-up/M-p     - 历史中上一个命令
    C-down/M-n   - 历史中下一个命令

默认的shell启动后并没有增加必要的启动选项，因此需要手工补充。
常见的内容包括：

* 需要使用`code:add:path`命令添加的路径，如：
* 需要手工启动的applicationerlang-shell附件选项的手工添加方法：
	
####编译
    C-c C-k      - 编译当前缓冲区中的模块
    C-c C-l      - 显示编译结果（并进入结果所在窗口）
    C-u C-x`     - 开始从头解析编译结果，并移至第一个出错行
    C-x`         - 移动到下一个出错行

###dired-detail
为了避免dired显示太多内容，可以使用[dired-details](http://www.emacswiki.org/emacs/dired-details.el)插件。

####配置
    ;;prevent dired too much info
    (add-to-list 'load-path "~/.emacs.d/dired-details")
    (require 'dired-details)
    (dired-details-install) 

####临时切换
    ;;   ) - dired-details-show
    ;;   ( - dired-details-hide

###projectle
通过projectle的配置，可以在git项目中做深层文件查找，项目文件目录比较复杂时仍可得心应手。
配合安装以下包可以更进一步：

* helm-projectile 快速切换项目等
* ido 简化文件名搜索
* recentf 列举最近访问过的文件（内置的包）

####安装
参见[github上的projectile项目](https://github.com/bbatsov/projectile)。

* C-c p C-h   查看帮助：列举projectile命令
* C-c p f     查看项目中的文件
* C-c p d     打开单个目录
* C-c p D     打开目录列表（配合dired-detail可以切换长显示和短显示）
* C-c p !     在项目根目录执行shell命令
* C-c p v     `vc-dir`指令，如果是git则自动执行`magit-status`

基础概念
--------
###文件缓冲区
虽然缓冲区看起来和文件非常相像，但它只是一个临时性的工作区域，里面可能包含的是文件的一份副本。

###插入点
光标前的位置就是插入点。

###删除环
被某些命令（`C-k`等）删除的文本将进入删除环，以供`C-y`或`M-y`粘贴操作使用。

###默认快捷键约定
* 最常用的命令，C-{n}
* 次常用的命令，M-{n}
* 其他常用命令，C-x {something} RETURN
* 特殊命令，    C-c {something} RETURN
* 全命令执行，  M-x {long-command-name} RETURN

基本命令
--------
* C-x C-c            退出
* M-x [full-command] 执行全名命令
* C-x C-h            查询所有C-x命令
* C-c C-h            查询所有C-c命令
* C-g                取消命令 

副模式命令
----------
* 自动换行模式（auto-fill mode）
* 改写模式（overwrite mode）
* 自动保存模式（auto-save mode），定期保存到临时文件
* 行号模式（line number mode）
* 临时标记模式（transient mark mode）

文件操作命令
-----------
* C-x C-f   find-file                查找文件并在新的缓冲区打开
* C-x C-v   find-alternate-file      读入另一个文件，并替换当前缓冲区
* C-x C-s   save-buffer              从缓冲区保存文件到磁盘
* C-x C-w   write-file               把缓冲区写入到另一个文件
* C-x C-c   save-buffers-kill-emacs  退出Emacs
* C-h       help-command

光标移动命令
-----------
* C-f   forward-char
* C-b   backward-char
* C-p   previous-line
* C-n   next-line
* M-f   forward-word
* M-b   backward-word
* C-a   beginning-of-line
* C-e   end-of-line
* C-v   scroll-up
* M-v   scroll-down
* M-<   beginning-of-buffer
* M->   end-of-buffer
*       goto-line
* M-{n} digit-argument 重复执行n次后续命令
* C-u {n} universal-argument 重复执行n次后续命令（省略n时重复4次或16次）

文本删除命令
------------
* C-d   delete-char
* DEL   delete-backward-char
* M-d   kill-word
* M-DEL backward-kill-word 删除光标前面的单词
* M-z   一直删除到指定字母
* C-k   kill-line
* M-k   kill-sentence
* C-y   yank 粘贴删除环中第一个文本
* M-y   循环粘贴删除环中其他文本，来替代C-y所粘贴的文本
* C-x u 撤销上一次命令（如删除命令或输入命令）
* C-w   kill-region 删除文本块

文本块常用操作步骤
------------------
###标记文本块
1. 移动光标到文本块开始位置
2. C-@设置标记
3. 移动光标到结束位置
4. （如有必要）C-x C-x检验标记范围是否正确
###删除文本块
1. 标记好准备删除的文本块
2. C-w 删除（进入删除环）
###移动文本
1. 删除文本块
2. 移动光标到插入点
3. C-y插入文本块
###复制文本
1. 标记文本
2. M-w复制文本
3. 移动光标到插入点
4. C-y插入文本块

文本块操作命令
-------------
* C-@     set-mark-command
* C-x C-x exchange-point-and-mark
* C-w     kill-region
* M-w     kill-ring-save 将文本块复制到删除环上
* M-h     mark-paragraph 选择段落
* C-x C-p mark-page 标记页面
* C-x h   mark-whole-buffer 全选
* M-y     yank-pop 在用过C-y命令以后寻找删除环上的其他文本块

段落重排
-------
* M-q fill-paragraph 重排段落
*     fill-region 重排文本块

编辑技巧
-------
* C-t     transpose-chars
* M-t     transpose-words
* C-x C-t transpose-lines
* M-c     capitalize-word 切换首字母为大写
* M-u     upcase-word     转换为大写
* M-l     downcase-word   转换为小写
* C-x u   undo
*         revert-buffer 撤销上次存盘之后的所有修改
* C-x ESC ESC 重复执行上一次复杂命令
* C-q <tab> 输入Tab键（C-q后面的键盘输入会作为原始输入）

递增查找命令
-----------
* C-s isearch-forward
* C-r isearch-backward
* RETURN 退出查找操作
* C-g keyboard-quit 取消查找命令
* C-s C-w 把光标位置处的单词用作查找字符串
* C-s C-s 重复刚才的查找操作
* ESC C-s  向前正则查找
* ESC C-r  反向正则查找

查找－替换操作
--------------
* ESC %     开始查找－替换操作
*  y        用新字符串替换查询到的字符串，然后前进到下一个位置
*  n        不替换；前进到下一个位置
*  .        在当前位置替换后退出查询
*  ,        替换并显示替换情况，再按空格或y才移动到下一个位置
*  q        退出查询
*  C-r      进入递归编辑状态
*  C-w      删除此处内容，并进入递归编辑状态（好做其他修改）
*  ESC C-c  退出递归状态

窗口命令
-------
* C-x o    other-window
* C-x 0    delete-window
* C-x 1    delete-other-window
* C-x 2    在下面打开窗口
* C-x 3    在右侧打开窗口
* C-x ^    enlarge-window 价高当前窗口
*          shrink-window  压低当前窗口
* C-x }    enlarge-window-horizontally 加宽当前窗口
* C-x {    shrink-window-horizontally  压窄当前窗口
* ESC C-v  scroll-other-window 对其他窗口做卷屏操作
* C-x 4 f  find-file-other-window 在其他窗口打开一个文件
* C-x 4 b  swith-to-buffer-other-window 在其他窗口里选择一个缓冲区

缓冲区命令
---------
* C-x b    switch-to-buffer
* C-x C-b  list-buffer
*  d       待删标记
*  s       待存标记
*  u       去除操作标记
*  x       执行批量缓冲区操作
*  f       窗口内打开缓冲区内容
*  o       在新窗口打开缓冲区内容
*  q       退出
* C-x k    kill-buffer
*          rename-buffer
* C-x left/right  切换缓冲区

书签
----
* C-x r l  bookmark-menu-list
*  d       标记待删除书签
*  r       重命名书签
*  s       保存全部书签
*  f       显示光标位置的书签
*  u       去掉书签上的待操作标记
*  q       退出
* C-x r m  bookmark-set 在当前光标位置处设置一个书签
* C-x r b  bookmark-jump 跳到书签指示位置

Shell交互
---------
* C-z        临时退出到shell
* jobs
* fg         从shell返回到emacs
* ESC !      执行一次shell命令
*            shell
