#lang racket/base
(require racket/class
         "interfaces.rkt")

;; ----

(define (!digest? x) (is-a? x digest-impl%))
(define (digest? x) (is-a? x digest-ctx%))
(define (!hmac? x) (is-a? x hmac-ctx%))

(define digest-new make-digest-ctx)
(define (-digest-ctx x) (get-field ctx x))  ;; used by pkey.rkt

(define digest->bytes digest-peek-final)

(define hmac-new make-hmac-ctx)
(define hmac-update! digest-update!)
(define hmac-final! digest-final!)
(define hmac? !hmac?)

;; ----

(define !cipher? cipher-impl?)
(define cipher? cipher-ctx?)

(define cipher-encrypt cipher-new-encrypt)
(define cipher-decrypt cipher-new-decrypt)

(define (cipher-encrypt ci key iv #:padding pad?)
  (make-encrypt-cipher-ctx ci key #:iv iv #:pad? pad?))
(define (cipher-decrypt ci key iv #:padding pad?)
  (make-decrypt-cipher-ctx ci key #:iv iv #:pad? pad?))

(define cipher-key-length cipher-key-size)
(define cipher-iv-length cipher-iv-size)

;; ----

(define (!pkey? x) (is-a? x pkey-impl%))
(define (pkey? x) (is-a? x pkey-ctx%))
(define (-pkey-type x) (send x get-impl))