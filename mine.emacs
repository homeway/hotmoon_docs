;; 默认是nil，开启之后使用拷贝模式，以避免产生结尾为~的备份文件
(setq backup-by-copying t) 

;; 去掉菜单显示（mac下无法使用）
(menu-bar-mode -1)
;; 显示行号
(global-linum-mode 1)
;; recentf是内置的
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; 包管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;  '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(package-initialize)

;; 最好的显示模板 solarized color theme
(load-theme 'solarized-light t)

;; erlang mode
(setq user-mail-address "homeway.xue@gmail.com")
(setq load-path (cons "~/erlang/erts/r17/lib/tools-2.6.14/emacs/" load-path))
(setq erlang-root-dir "~/erlang/erts/r17")
(setq exec-path (cons "~/erlang/erts/r17/bin/" exec-path))
(require 'erlang-start)

;; mardkown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))

;; 避免dired显示太多无用的信息
;; 使用)或(切换
(add-to-list 'load-path "~/.emacs.d/dired-details")
(require 'dired-details)
(dired-details-install)

;; flx-ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; helm
(require 'helm-config)

;; 按项目的方式管理文件和目录 projectile
;; 默认全局使用
;;(add-to-list 'load-pat "~/.emacs.d/elpa/projectile-0.11.0")
(require 'projectile)
(projectile-global-mode)
;; 默认打开缓存
;;(setq projectile-enable-caching t)
;; 使用f5键打开默认文件搜索
;;(global-set-key [f5] 'projectile-find-file)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "dcfd4272e86ca2080703e9ef00657013409315d5eb13ea949929f391cdd2aa80" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
