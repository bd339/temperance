(in-package #:bones.wam)

(define-constant +cell-width+ 16
  :documentation "Number of bits in each heap cell.")

(define-constant +cell-tag-width+ 2
  :documentation "Number of bits reserved for cell type tags.")

(define-constant +cell-value-width+ (- +cell-width+ +cell-tag-width+)
  :documentation "Number of bits reserved for cell values.")

(define-constant +cell-tag-bitmask+ #b11
  :documentation "Bitmask for masking the cell type tags.")


(define-constant +heap-limit+ (expt 2 +cell-value-width+)
  ;; We can only address 2^value-bits cells.
  :documentation "Maximum size of the WAM heap.")


(define-constant +code-word-size+ 16
  :documentation "Size (in bits) of each word in the code store.")

(define-constant +code-limit+ (expt 2 +code-word-size+)
  :documentation "Maximum size of the WAM code store.")

(define-constant +code-sentinal+ (1- +code-limit+)
  :documentation "Sentinal value used in the PC and CP.")


(define-constant +tag-null+      #b00
  :documentation "An empty cell.")

(define-constant +tag-structure+ #b01
  :documentation "A structure cell.")

(define-constant +tag-reference+ #b10
  :documentation "A pointer to a cell.")

(define-constant +tag-functor+   #b11
  :documentation "A functor.")


(define-constant +functor-arity-width+ 4
  :documentation "Number of bits dedicated to functor arity.")

(define-constant +functor-arity-bitmask+ #b1111
  :documentation "Bitmask for the functor arity bits.")


(define-constant +register-count+ 16
  :documentation "The number of registers the WAM has available.")

(define-constant +maximum-arity+ (1- (expt 2 +functor-arity-width+))
  :documentation "The maximum allowed arity of functors.")


(define-constant +maximum-query-size+ 256
  :documentation
  "The maximum size (in bytes of bytecode) a query may compile to.")


;;;; Opcodes
;;; Program
(define-constant +opcode-get-structure+ 1)
(define-constant +opcode-unify-variable+ 2)
(define-constant +opcode-unify-value+ 3)
(define-constant +opcode-get-variable+ 4)
(define-constant +opcode-get-value+ 5)


;;; Query
(define-constant +opcode-put-structure+ 6)
(define-constant +opcode-set-variable+ 7)
(define-constant +opcode-set-value+ 8)
(define-constant +opcode-put-variable+ 9)
(define-constant +opcode-put-value+ 10)

;;; Control
(define-constant +opcode-call+ 11)
(define-constant +opcode-proceed+ 12)
