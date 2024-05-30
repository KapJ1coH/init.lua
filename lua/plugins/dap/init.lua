return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},

	keys = {
		{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>" },
		{ "<leader>dc", "<cmd>lua require('dap').continue()<CR>" },
		{ "<leader>dd", "<cmd>lua require('dap').step_out()<CR>" },
		{ "<leader>di", "<cmd>lua require('dap').step_into()<CR>" },
		{ "<leader>do", "<cmd>lua require('dap').step_over()<CR>" },
		{ "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>" },
		{ "<leader>ds", "<cmd>lua require('dap').stop()<CR>" },
		{ "<leader>dt", "<cmd>lua require('dap').toggle()<CR>" },
		{ "<leader>du", "<cmd>lua require('dap').up()<CR>" },
		{ "<leader>dw", "<cmd>lua require('dap').down()<CR>" },
	},

	config = function()
		local adapters = require("plugins.dap.adapters")
		local configurations = require("plugins.dap.configs")

		local mason = require("mason")
		local mason_dap = require("mason-nvim-dap")
		local dap = require("dap")
		local ui = require("dapui")

		-- dap.set_log_level("TRACE")

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Debuggers                                                │
		-- ╰──────────────────────────────────────────────────────────╯
		-- We need the actual programs to connect to running instances of our code.
		-- Debuggers are installed via https://github.com/jayp0521/mason-nvim-dap.nvim
		mason.setup()
		mason_dap.setup({
			ensure_installed = { "python", "cppdbg" },
			automatic_installation = true,
		})

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Adapters                                                 │
		-- ╰──────────────────────────────────────────────────────────╯
		-- Neovim needs a debug adapter with which it can communicate. Neovim can either
		-- launch the debug adapter itself, or it can attach to an existing one.
		-- To tell Neovim if it should launch a debug adapter or connect to one, and if
		-- so, how, you need to configure them via the `dap.adapters` table.
		adapters.setup(dap)

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Configuration                                            │
		-- ╰──────────────────────────────────────────────────────────╯
		-- In addition to launching (possibly) and connecting to a debug adapter, Neovim
		-- needs to instruct the adapter itself how to launch and connect to the program
		-- that you are trying to debug (the debugee).
		configurations.setup(dap)

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Keybindings + UI                                         │
		-- ╰──────────────────────────────────────────────────────────╯
		vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

		ui.setup({
			icons = { expanded = "▾", collapsed = "▸" },
			mappings = {
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			layouts = {
				{
					elements = {
						"scopes",
					},
					size = 0.3,
					position = "right",
				},
				{
					elements = {
						"repl",
						"breakpoints",
					},
					size = 0.3,
					position = "bottom",
				},
			},
			floating = {
				-- max_height = nil,
				-- max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil,
			},
		})
	end,
}
