require('blink.cmp').setup({
    -- no command line blink
    cmdline = { enabled = false },

    keymap = {
        -- set maps to be similar to and compatible with supertab
        preset = 'super-tab',
    },

    appearance = {
        nerd_font_variant = 'mono'
    },

    completion = {
        documentation = { auto_show = false },
        trigger = { show_on_keyword = false },

        menu = {
            draw = {
                -- hide icons
                columns = { { "label", "label_description", gap = 1 } },
            },
        },
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning"
    },

    -- enable experimental signature helper
    signature = { enabled = true },
})
