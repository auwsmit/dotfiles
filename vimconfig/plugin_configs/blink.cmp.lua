require('blink.cmp').setup({
    -- no command line blink
    cmdline = { enabled = false },

    -- set maps for supertab compatibility
    keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = 'default',

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },

        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then return cmp.accept()
                else return cmp.select_and_accept() end
            end,
            'snippet_forward',
            'fallback'
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    appearance = {
        nerd_font_variant = 'mono'
    },

    completion = {
        documentation = { auto_show = false },
        trigger = { show_on_keyword = false },
        -- menu = {
        --     draw = {
        --         -- You can customize the components to hide icons
        --         columns = { { "label", "label_description", gap = 1 } },
        --     },
        -- },
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
