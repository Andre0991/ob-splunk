;;; ob-splunk.el --- org-babel functions for Splunk search

;; Author: André Peric Tavares
;; Keywords: literate programming, splunk
;; Homepage: https://github.com/Andre0991/ob-splunk/
;; Version: 0.01

;; Usage:
;; Set the `splunk-search-url` variable and evaluate a `splunk` org src block
;; that contains a Splunk query. A Splunk search will be open in the browser.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(require 'ob)
(require 'url-util)

;;; editable splunk src code blocks
(unless (assoc "splunk" org-src-lang-modes)
  (add-to-list 'org-src-lang-modes '("splunk" . funamental)))

;;; Splunk
(defvar splunk-search-url nil
  "Example: \"https://foo.splunkcloud.com/en-US/app/search/search\"")

(defun splunk-search (query-str)
  (if splunk-search-url
      (browse-url (concat splunk-search-url "?q=" (url-hexify-string query-str)))
    "`splunk-search-url` is not set."))

;;; Babel

;; default header arguments
(defvar org-babel-default-header-args:splunk '((:results . "output silent")))

(defun org-babel-expand-body:splunk (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  (format "(splunk-search %S)" body))

(defun org-babel-execute:splunk (body params)
  "Execute a block of Splunk code with org-babel.
This function is called by `org-babel-execute-src-block'"
  (eval (read (org-babel-expand-body:splunk body params))))

(provide 'ob-splunk)
