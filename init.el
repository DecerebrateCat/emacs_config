;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.

;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("melpa-stable" . "http://stable.melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; ここにいっぱい設定を書く

;; https://qiita.com/ohataken/items/3b29ea330dde71113b9f

;;; theme
(leaf srcery-theme
  :config
  (load-theme 'srcery t))

(leaf counsel
  :init
  (counsel-mode 1)
  :bind (
    "C-x b" . counsel-switch-buffer))

(leaf ivy-rich
  :config
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  (ivy-rich-mode 1))

(leaf ivy-prescient
  :config
  (custom-set-variables '(prescient-save-file (locate-user-emacs-file "tmp/prescient-save.el")))
  (ivy-prescient-mode t)
  (prescient-persist-mode t))

(leaf smooth-scrolling
  :init
  (setq smooth-scroll-margin 1)
  :config
  (smooth-scrolling-mode t))

(leaf smart-mode-line
  :config
  (setq sml/theme 'respectful)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;; スタート時のスプラッシュ非表示
(setq inhibit-startup-message t)

;;; キーバインド
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-for-help) ; ヘルプ
(define-key global-map "\C-\\" nil) ; \C-\の日本語入力の設定を無効にする

;;; 色を付ける
(global-font-lock-mode t)

;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)

;;; スクロールを一行ずつにする
(setq scroll-step 1)

;;; 画面右端で折り返さない
(setq-default truncate-lines t)
(setq truncate-partial-width-windows t)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)

;;; モードラインに情報を表示
(display-time)
(line-number-mode 1)
(column-number-mode 1)

;;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;;; タブをスペース4字
(setq-default tab-width 4 indent-tabs-mode nil)


(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8bb9cbdc1fe6f4451b1e1361113cd6e24b784f82f33a0f4d6c5f8991aa32b28c" default))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/")))
 '(package-selected-packages
   '(ivy-prescient ivy-rich smart-mode-line smooth-scrolling counsel-edit-mode srcery-theme blackout el-get hydra leaf-keywords leaf))
 '(prescient-save-file (locate-user-emacs-file "tmp/prescient-save.el")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
