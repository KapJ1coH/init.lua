-- local bufnr = vim.api.nvim_get_current_buf()
-- vim.keymap.set(
--     "n",
--     "<leader>a",
--     function()
--         vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
--         -- or vim.lsp.buf.codeAction() if you don't want grouping.
--     end,
--     { silent = true, buffer = bufnr }
-- )
-- vim.keymap.set(
--     "n",
--     "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
--     function()
--         vim.cmd.RustLsp({ 'hover', 'actions' })
--     end,
--     { silent = true, buffer = bufnr }
-- )


return {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy


    keys = {
        -- Rustaceanvim's keybindings are already set in the snippet above
        { 'n', '<leader>ra', function ()
            vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        end},
        { 'n', 'K', function ()
            vim.cmd.RustLsp({ 'hover', 'actions' })
        end},
    },

}
