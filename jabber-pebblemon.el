;;; jabber-pebblemon.el --- PebbLemon integration for jabber.el

;; Copyright (C) 2013 James Andariese

;; Author: James Andariese <james@strudelline.net>
;; Version: 1.3
;; Package-Requires: ((pebblemon "1.0"))
;; Keywords: pebble jabber

;;; Commentary:

;; This package provides PebbLemon integration for jabber.el
;; To activate it, use the following line customize the jabber-alert-message-hooks variable
;; or (add-hook 'jabber-alert-message-hooks 'jabber-pebblemon-message-hook)

;;; Code:

;;;###autoload
(defun jabber-pebblemon-message-hook (from buf text proposed-alert)
  "Send incoming message to PebbLemon"
  (let ((sender (if jabber-pebblemon-strip-hostname
		    (car (split-string from "@"))
		  from)))
    (pebblemon-send (format jabber-pebblemon-title-format sender) text)))

;;;###autoload
(defgroup jabber-pebblemon nil
  "Jabber PebbLemon integration options"
  :prefix '(jabber-pebblemon)
  :group 'jabber)

;;;###autoload
(defcustom jabber-pebblemon-strip-hostname
  t
  "Strip hostname (part after @) from sender's username when included in title"
  :type '(boolean)
  :group 'jabber-pebblemon)

;;;###autoload
(defcustom jabber-pebblemon-title-format
  "jabber.el\n%s"
  "Title format.  %s is replaced with the username of the sender"
  :type '(string)
  :group 'jabber-pebblemon)

;;;###autoload
(custom-add-frequent-value 'jabber-alert-message-hooks
			   'jabber-pebblemon-message-hook)
;;; jabber-pebblemon.el ends here
