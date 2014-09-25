Emacs速查手册
============

Emacs24.3, MacOS 10.9.5

homeway.xue@gmail.com, 2014年9月25日

安装问题
--------

基础概念
--------
###文件缓冲区
虽然缓冲区看起来和文件非常相像，但它只是一个临时性的工作区域，里面可能包含的是文件的一份副本。

###编辑模式
###插入点
###窗口
###删除环
###默认快捷键
* 最常用的命令，C-{n}
* 次常用的命令，M-{n}
* 其他常用命令，C-x {something} RETURN
* 特殊命令，    C-c {something} RETURN
* 全命令执行，  M-x {long-command-name} RETURN

#递增查找
#递归查找

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
* M-c     capitalize-word
* M-u     upcase-word
* M-l     downcase-word
* C-x u   undo
*         revert-buffer 撤销上次存盘之后的所有修改
* C-x ESC ESC 重复执行上一次复杂命令

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
*  d       待删标记
*  s       待存标记
*  u       去除操作标记
*  x       执行批量缓冲区操作
*  f       窗口内打开缓冲区内容
*  o       在新窗口打开缓冲区内容
*  q       退出
* C-x C-b  list-buffer
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
