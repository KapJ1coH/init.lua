return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
    enabled = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("harpoon"):setup({
			menu = {
				width = vim.api.nvim_win_get_width(0) - 40,
			},
		})
		vim.api.nvim_create_autocmd({ "BufLeave", "ExitPre" }, {
			pattern = "*",
			callback = function()
				local filename = vim.fn.expand("%:p:.")
				local harpoon_marks = require("harpoon"):list().items
				for _, mark in ipairs(harpoon_marks) do
					if mark.value == filename then
						mark.context.row = vim.fn.line(".")
						mark.context.col = vim.fn.col(".")
						return
					end
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "harpoon file",
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "harpoon quick menu",
		},
		{
			"<C-h>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "harpoon to file 1",
		},
		{
			"<C-t>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "harpoon to file 2",
		},
		{
			"<C-s>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "harpoon to file 3",
		},
		{
			"<C-n>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "harpoon to file 4",
		},
	},
}
