;; init.el

;; 言語設定
(set-language-environment 'Japanese)

;; 文字コード
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; メニューバーの非表示
(menu-bar-mode -1)

;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; load-pathに追加するフォルダ
;; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp")


;; melpaリポジトリを使う
(require 'package)
(add-to-list 'package-archives
;;	     '("melpa" . "http://melpa.org/packages/") t)
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;helmのインストール用
(unless (package-installed-p 'helm)
    (package-refresh-contents) (package-install 'helm))

;;helmの設定
(when (require 'helm-config nil t)
  (helm-mode 1)



  )

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
		   :foreground "#800"
		   :height 0.9)
