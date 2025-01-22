-- lazy way
return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        -- branch = 'better-defaults',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    -- local cmp = require('cmp')
    --
    -- cmp.setup({
    --   preselect = 'item',
    --   completion = {
    --     completeopt = 'menu,menuone,noinsert'
    --   },
    --   mapping = cmp.mapping.preset.insert({
    --      ['<CR>'] = cmp.mapping.confirm({select = true}),
    --   })
    -- })
    --
    -- -- If you want insert `(` after select function or method item
    -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    -- cmp.event:on(
    --   'confirm_done',
    --   cmp_autopairs.on_confirm_done()
    -- )

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
            -- require('lspconfig').sqlls.setup {
            --     capabilities = capabilities,
            --     filetypes = { 'sql' },
            --     root_dir = function(_)
            --         return vim.loop.cwd()
            --     end,
            -- }

            -- require('lspconfig').sqls.setup {
            --     on_init = function(client)
            --         client.server_capabilities.documentFormattingProvider = false
            --         client.server_capabilities.documentFormattingRangeProvider = false
            --     end,
            --     on_attach = function(client, bufnr)
            --         require('sqls').on_attach(client, bufnr)
            --     end,
            -- }


            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set(
                    "n",
                    "gD",
                    vim.lsp.buf.declaration,
                    { desc = "Declaration", buffer = bufnr, remap = false }
                )
                vim.keymap.set(
                    "n",
                    "gd",
                    vim.lsp.buf.definition,
                    { desc = "Definition", buffer = bufnr, remap = false }
                )
                vim.keymap.set(
                    "n",
                    "gi",
                    vim.lsp.buf.implementation,
                    { desc = "Implementation", buffer = bufnr, remap = false }
                )
                vim.keymap.set("n", "<leader>lws", function()
                    vim.lsp.buf.workspace_symbol()
                end, { desc = "Workspace Symbol", buffer = bufnr, remap = false })

                vim.keymap.set("n", "<leader>vd", function()
                    vim.diagnostic.open_float()
                end, { desc = "Open Float", buffer = bufnr, remap = false })

                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, { desc = "Goto next", buffer = bufnr, remap = false })

                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, { desc = "Goto prev", buffer = bufnr, remap = false })

                vim.keymap.set("n", "<leader>lca", function()
                    vim.lsp.buf.code_action()
                end, { desc = "Code Action", buffer = bufnr, remap = false })

                vim.keymap.set("n", "<leader>lrr", function()
                    vim.lsp.buf.references()
                end, { desc = "References", buffer = bufnr, remap = false })

                vim.keymap.set("n", "<leader>lrn", function()
                    vim.lsp.buf.rename()
                end, { desc = "Rename Variable", buffer = bufnr, remap = false })

                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, { desc = "Signature Help", buffer = bufnr, remap = false })
                -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
            end)

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright" },
                handlers = {
                    -- lsp_zero.default_setup,
                    -- lua_ls = function()
                    -- 	-- (Optional) Configure lua language server for neovim
                    -- 	local lua_opts = lsp_zero.nvim_lua_ls()
                    -- 	require("lspconfig").lua_ls.setup(lua_opts)
                    -- end,
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })

            -- -- Autoformat on save with Black
            -- local group = vim.api.nvim_create_augroup("Black", { clear = true })
            -- vim.api.nvim_create_autocmd("bufWritePost", {
            --     pattern = "*.py",
            --     command = "silent !black %",
            --     group = group,
            -- })
        end,
    },
}
