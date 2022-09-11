local inspect = require("vim.inspect")
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
function _G.put(...)
	local objects = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end

	print(table.concat(objects, "\n"))
	return ...
end

-- general
lvim.format_on_save = false
lvim.lint_on_save = false
lvim.colorscheme = "onedarker"
lvim.builtin.dap.active = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
function Buffer_dir()
	-- require "telescope.builtin".find_files({search_dirs = {vim.fn.expand("%:p:h")}})
	require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h"), hidden = true })
end

lvim.builtin.telescope.on_config_done = function()
	local actions = require("telescope.actions")

	-- for input mode

	lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.move_selection_next
	lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.move_selection_previous
	lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.cycle_history_next
	lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.cycle_history_prev
	-- for normal mode
	lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
	lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
	lvim.builtin.telescope.defaults.mappings.n["q"] = actions._close

	local opts = {
		theme = "ivy",

		sorting_strategy = "ascending",

		layout_strategy = "bottom_pane",
		layout_config = {
			height = 8,
		},

		border = true,
		borderchars = lvim.builtin.telescope.defaults.borderchars,
		previewer = false,
		shorten_path = false,
	}

	local dropdown = require("telescope.themes").get_dropdown(opts)
	lvim.builtin.telescope.extensions["ui-select"] = dropdown
	require("telescope").load_extension("ui-select")

	lvim.builtin.which_key.mappings["l"].a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions" }
end

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["p"] = { p = { "<cmd>Telescope projects<CR>", "Projects" } }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	t = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
}
lvim.builtin.which_key.mappings["x"] = {
	name = "+Database",
	u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
	f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
	r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
	q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
}

lvim.builtin.which_key.mappings["b"].d = { "<cmd>BufferKill<cr>", "Delete Buffer" }
lvim.builtin.which_key.mappings["b"].b = { "<cmd>Telescope buffers<cr>", "Buffers" }

lvim.builtin.which_key.mappings["w"] = {
	name = "+Windows",
	w = { "<C-w><C-w>", "Switch" },
	l = { "<C-w><C-l>", "Go Left" },
	h = { "<C-w><C-h>", "Go Right" },
	k = { "<C-w><C-k>", "Go Up" },
	j = { "<C-w><C-j>", "Go Down" },
	v = { "<C-w><C-j>", "Vertical Split" },
	s = { "<C-w><C-j>", "Split" },
}

lvim.builtin.dap.on_config_done = function()
	lvim.builtin.which_key.mappings["d"] = {
		name = "Debug",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		p = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
		s = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Stop" },
		t = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		r = { "<cmd>lua require'dap'.continue()<cr>", "Run" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },

		e = { "<cmd>lua require'dapui'.eval()<cr>", "Eval" },
		w = { "<cmd>lua require'dapui'.float_element(watches)<cr>", "Watches" },
		v = { "<cmd>lua require'dapui'.toggle()<cr>", "Watches" },
	}
end

lvim.builtin.which_key.mappings["r"] = {
	name = "+Request",
	r = { "<cmd>lua require('rest-nvim').run()<cr>", "Execute" },
}

lvim.builtin.which_key.mappings["s"].b = { "<cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<cr>", "Switch" }
lvim.builtin.which_key.mappings["w"].v = { "<C-w><C-v>", "VSplit" }

lvim.keys.normal_mode["<Space>w"] = "<C-w>"
lvim.keys.normal_mode["<Space>wl"] = "<C-l>"
lvim.keys.normal_mode["<Space>wh"] = "<C-h>"
lvim.keys.normal_mode["<Space>wk"] = "<C-w>k"
lvim.keys.normal_mode["<Space>wj"] = "<C-w>j"
lvim.keys.normal_mode["<Space>wd"] = "<cmd>q<cr>"
lvim.keys.normal_mode["<Space>wv"] = "<C-w><C-v>"
lvim.keys.normal_mode["<Space>ws"] = "<cmd>split<cr>"
lvim.keys.normal_mode["gD"] = "<cmd>Telescope lsp_references<CR>"
lvim.keys.normal_mode["<Space>gg"] = "<cmd>Neogit<CR>"
lvim.keys.visual_mode["gp"] = "<cmd>'<,'>diffput<CR>"
lvim.builtin.which_key.mappings["g"] = {
	g = { "<cmd>Neogit<CR>", "Neogit" },
	d = { "<cmd>DiffviewOpen<CR>", "Diff" },
	q = { "<cmd>DiffviewClose<CR>", "Close Diff" },
	p = { "<cmd>'<,'>diffput<CR>", "Diff put" },
}

print(vim.inspect(require("diffview.actions").goto_file))

lvim.keys.normal_mode["gss"] = "<cmd>HopChar2<CR>"
lvim.keys.normal_mode["<Space><"] = "<cmd>HopChar2<CR>"
lvim.keys.normal_mode["<Space>*"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>."] = "<cmd>lua Buffer_dir()<CR>"
lvim.keys.normal_mode["-"] = nil

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.treesitter.on_config_done = function()
	local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
	parser_configs.http = {
		install_info = {
			url = "https://github.com/NTBBloodbath/tree-sitter-http",
			files = { "src/parser.c" },
			branch = "main",
		},
	}
end

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end
-- set a formatter if you want to override the default lsp one (if it exists)

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "eslint_d",
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
})

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "prettier", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
})
-- Additional Plugins
lvim.plugins = {
	{ "nvim-orgmode/orgmode" },
	{ "norcalli/nvim-colorizer.lua" },
	{
		"nanotee/sqls.nvim",
		config = function()
			require("lspconfig").sqls.setup({
				on_attach = function(client, bufnr)
					require("sqls").on_attach(client, bufnr)
				end,
				settings = {
					sqls = {
						connections = {
							{
								driver = "mysql",
								dataSourceName = "mysql://vxos:vxos@127.0.0.1:3306/vxdb",
							},
						},
					},
				},
			})
		end,
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup({
				external_config = {
					enable = true,
					path = (function()
						print(vim.inspect(require("lspconfig.util").find_git_ancestor(vim.loop.fs_realpath("."))))
						return require("lspconfig.util").find_git_ancestor(vim.loop.fs_realpath(".")) .. "/dap-go.json"
					end)(),
				},
			})
		end,
	},
	{
		"tpope/vim-dadbod",
		requires = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			local diffactions = require("diffview.config").actions
			require("diffview").setup({
				keymaps = {
					view = {
						["gq"] = "<cmd>DiffviewClose<CR>",
						["<leader>b"] = false,
						["<leader>ge"] = diffactions.toggle_files,
					},
				},
			})
		end,
	},
	{
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				integrations = {
					diffview = true,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				-- Jump to request line on run
				jump_to_request = false,
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
}

local dap = require("dap")
dap.adapters.go = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/vscode-go/dist/debugAdapter.js" }, -- specify the path to the adapter
}
-- dap.adapters.go = function(callback, config)
-- 	local stdout = vim.loop.new_pipe(false)
-- 	local handle
-- 	local pid_or_err
-- 	local host = config.host or "127.0.0.1"
-- 	local port = config.port or "38697"
-- 	local addr = string.format("%s:%s", host, port)
-- 	local opts = {
-- 		stdio = { nil, stdout },
-- 		args = { "dap", "-l", addr },
-- 		detached = true,
-- 	}
-- 	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
-- 		stdout:close()
-- 		handle:close()
-- 		if code ~= 0 then
-- 			print("dlv exited with code", code)
-- 		end
-- 	end)
-- 	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
-- 	stdout:read_start(function(err, chunk)
-- 		assert(not err, err)
-- 		if chunk then
-- 			vim.schedule(function()
-- 				require("dap.repl").append(chunk)
-- 			end)
-- 		end
-- 	end)
-- 	-- Wait for delve to start
-- 	vim.defer_fn(function()
-- 		callback({ type = "server", host = "127.0.0.1", port = port })
-- 	end, 100)
-- end

dap.set_log_level("DEBUG")
-- dap.adapters.node2 = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/.emacs.d/.extension/vscode/ms-vscode.node-debug2/extension/out/src/nodeDebug.js" },
-- }
-- dap.configurations.go = {
-- 	{
-- 		type = "go",
-- 		name = "Debug",
-- 		request = "launch",
-- 		program = "${workspaceFolder}",
-- 	},
-- }
-- dap.configurations.typescript = {
-- 	{
-- 		type = "node2",
-- 		request = "launch",
-- 		args = { "/home/tocha/develop/aidmed-website-my/src/app.ts" },
-- 		runtimeArgs = { "--nolazy", "-r", "ts-node/register" },
-- 		cwd = "/home/tocha/develop/aidmed-website-my/",
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		console = "integratedTerminal",
-- 	},
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
-- -   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
