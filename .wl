(setq gnutls-verify-error t)
(setq gnutls-min-prime-bits 1024)
(setq gnutls-algorithm-priority "SECURE128:-VERS-SSL3.0:-VERS-TLS1.3")

;; IMAP, gmail:
(setq elmo-imap4-default-server "imap.gmail.com"
      elmo-imap4-default-user "takechi101010@gmail.com"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl

      ;; For non ascii-characters in folder-names
      elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "takechi101010"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-from "Takeshi Watanabe <takechi101010@gmail.com>"

      ;; All system folders (draft, trash, spam, etc) are placed in the
      ;; [Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder   "%[Gmail]/Drafts"
      wl-trash-folder   "%[Gmail]/Trash"
      ;; The below is not necessary when you send mail through Gmail's SMTP server,
      ;; see https://support.google.com/mail/answer/78892?hl=en&rd=1
      ;; wl-fcc            "%[Gmail]/Sent"

      ;; Mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      wl-message-ignored-field-list '(".+")
      wl-message-visible-field-list '("To" "Cc" "Subject" "From")

      ;; For auto-completing foldernames
      wl-default-spec "%")
