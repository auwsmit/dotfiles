; Load this file after default queries
;; extends

; Separate comma, period, and square brackets to be highlighted as operators
; -----------------------------------------------------------------------------
; By default, comma and period are the highlight group @punctuation.delimiter
; Square bracket is @punctuation.bracket, along with parenthesis and curly brackets
(["," "." "[" "]"]) @operator
