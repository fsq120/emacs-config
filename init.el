(add-to-list 'load-path "~/.emacs.d")

(global-font-lock-mode t)

;; C-x v = for vc-ediff
(global-set-key "\M-g=" 'vc-ediff)

;; M-s to switch to buffer *shell* or start shell if *shell does not exist
(defun switch-to-shell ()
  (interactive)
  (other-window 1)
  (if (get-buffer "*shell*")
      (switch-to-buffer (get-buffer "*shell*"))
    (shell)))
(global-set-key [(meta s)] 'switch-to-shell)
(ansi-color-for-comint-mode-on)

;; M-v, C-v for half screen scrolling
(defun window-half-height ()
     (max 1 (/ (1- (window-height (selected-window))) 2)))
   
(defun scroll-up-half ()
  (interactive)
  (previous-line (window-half-height)))
   
(defun scroll-down-half ()         
  (interactive)                    
  (next-line (window-half-height)))

(global-set-key [(control v)] 'scroll-up-half)
(global-set-key [(meta v)] 'scroll-down-half)

;; compile code using C-q
(global-set-key [(control q)] 'compile)

;; back space key
(global-set-key [(control h)] 'delete-backward-char)

;; c style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; shell tab completion
(require 'shell-completion)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

;; show column number of cursor
(column-number-mode 1)

;; show 80c column limit
(require 'column-marker)
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (column-marker-1 80)
	     ))

(add-hook 'python-mode-hook
	  '(lambda ()
	     (column-marker-1 80)
	     ))

;; gtags-mode
(setq gtags-suggested-key-mapping 1)
(add-to-list 'load-path "~/share/gtags")
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (gtags-mode 1)
	     ))

;; Automatic file header
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.py\\'" . "Python file")
     '(
       "Short description: "
       "# " \n
       "# "(file-name-nondirectory (buffer-file-name)) \n
       "#" > \n
       "# Author: jonefeng (shouqiang.fsq@ant-financial.com)" > \n
       "# Created on: " (format-time-string "%Y-%m-%d") > \n
       "#" > \n
       "# Copyright (c) Tencent.com, Inc. All Rights Reserved" > \n
       > \n \n)))

(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.\\([Hh]\\|hh\\|hpp\\|cuh\\)\\'" . "C/C++ header file")
     '(
       "Short description: "
       "/**\n * "
       (file-name-nondirectory (buffer-file-name)) \n
       " *" > \n
       " * Author: jonefeng (shouqiang.fsq@ant-financial.com)" > \n
       " * Created on: " (format-time-string "%Y-%m-%d") > \n
       " *" > \n
       " * Copyright (c) Tencent.com, Inc. All Rights Reserved" > \n
       " *" > \n
       " */" > \n \n
       "#pragma once" > \n \n)))

(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.\\([Cc]\\|cc\\|cpp\\|cu\\)\\'" . "C/C++ file")
     '(
       "Short description: "
       "/**\n * "
       (file-name-nondirectory (buffer-file-name)) \n
       " *" > \n
       " * Author: jonefeng (shouqiang.fsq@ant-financial.com)" > \n
       " * Created on: " (format-time-string "%Y-%m-%d") > \n
       " *" > \n
       " * Copyright (c) Tencent.com, Inc. All Rights Reserved" > \n
       " *" > \n
       " */" > \n \n)))

;; auto-completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; for verilog mode
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

(autoload 'vhdl-mode "vhdl-mode" "VHDL mode" t )
(add-to-list 'auto-mode-alist '("\\.vhd\\'" . vhdl-mode))

(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
try-expand-dabbrev-visible
try-expand-dabbrev-all-buffers
try-expand-dabbrev-from-kill
try-complete-file-name-partially
try-complete-file-name
try-expand-all-abbrevs
try-expand-list
try-expand-line
try-complete-lisp-symbol-partially
try-complete-lisp-symbol))

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; auto load last file 
(desktop-save-mode 1)

(defun my-insert (num1 num2 prefix)
  (let ((@ num1))
    (save-restriction
      (while (< @ num2)
        (insert (format prefix @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @))
        (setq @ (1+ @))))))


;;===========================================================================
;;sr-speedbar-mode
;;===========================================================================
(require 'sr-speedbar)
(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)))
;;默认显示所有文件

;;sr-speedbar-right-side 把speedbar放在左侧位置
;;sr-speedbar-skip-other-window-p 多窗口切换时跳过speedbar窗口
;;sr-speedbar-max-width与sr-speedbar-width-x 设置宽度
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 30)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-auto-refreshs t)
(setq dframe-update-speed t)        ; prevent the speedbar to update the current state, since it is always changing

;; 绑定快捷键
(global-set-key (kbd "C-c C-t") 'sr-speedbar-toggle)
(global-set-key (kbd "TAB") 'c-indent-line-or-region)

(setq-default indent-tabs-mode nil)

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; color theme
(require 'color-theme)
;;(color-theme-initialize)
(color-theme-euphoria)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "#00ff00" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

 ;;
;; win:resume-windows --> windows 状态保存跟复原
;;______________________________________________________________________
 
;;; 安装
;; http://www.emacswiki.org/emacs/WindowsMode
;; http://www.gentei.org/~yuuji/software/
;; (install-elisp "http://www.gentei.org/~yuuji/software/windows.el")
;; (install-elisp "http://www.gentei.org/~yuuji/software/revive.el")
 
;;; windows.el 快捷键设定
(setq win:switch-prefix "\C-z")
;; 布局信息文件保存位置
(setq win:configuration-file "~/.windows")
(require 'windows)
 
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
 
;; 启动时自动复原
(add-hook 'after-init-hook (lambda() (run-with-idle-timer 0 nil 'my-resume-windows)))
(defun my-resume-windows ()
  "restore windows status ."
  (interactive)
   (resume-windows t)
   (clear-active-region-all-buffers)
  )
 
;; 关闭时自动保存
(add-hook 'kill-emacs-hook 'win-save-all-configurations)

;; add protobuf
(require 'protobuf-mode)
(autoload 'protobuf-mode "protobuf-mode" "protobuf mode" t )
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\\.prototxt\\'" . protobuf-mode))

(global-set-key (kbd "C-z") 'undo)
(setq inhibit-startup-message t)
(setq column-number-mode t)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(require 'xt-mouse)
(xterm-mouse-mode)
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(setq mouse-wheel-follow-mouse 't)
;;(global-set-key (kbd "<mouse-4>") 'scroll-up-half)
;;(global-set-key (kbd "<mouse-5>") 'scroll-down-half)

(defun smooth-scroll (increment)
  (scroll-up increment) (sit-for 0.05)
  (scroll-up increment) (sit-for 0.02)
  (scroll-up increment) (sit-for 0.02)
  (scroll-up increment) (sit-for 0.05)
  (scroll-up increment) (sit-for 0.06)
  (scroll-up increment))

(global-set-key [(mouse-5)] '(lambda () (interactive) (smooth-scroll 1)))
(global-set-key [(mouse-4)] '(lambda () (interactive) (smooth-scroll -1)))
