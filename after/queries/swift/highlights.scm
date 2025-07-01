;; extends

((protocol_declaration name: (type_identifier) @code.interface) (#set! priority 200))
((class_declaration name: (type_identifier) @code.class) (#set! priority 200))
((custom_operator) @code.operator (#set! priority 200))

((value_argument name: (value_argument_label) @code) (#set! priority 150))

((type_identifier) @lsp.type.struct (#set! priority 200))
((type_identifier) @type (#set! priority 150))
