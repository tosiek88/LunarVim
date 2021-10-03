-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end
-- general
-- lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
_G.Buffer_dir = function()
  print(vim.inspect("test"))
end

lvim.builtin.telescope.on_config_done = function()
  local actions = require "telescope.actions"

  -- for input mode
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
  -- for normal mode
  lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.n["q"] = actions._close
end

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["p"] = { p={ "<cmd>Telescope projects<CR>", "Projects" }}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Telescope lsp_references<cr>", "References" },
  f = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Telescope quickfix<cr>", "QuickFix" },
  l = { "<cmd>Telescope loclist<cr>", "LocationList" },
  w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}

lvim.builtin.which_key.mappings["b"] = {
  name = "+Buffers",
  b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  d = { "<cmd>BufferDelete<cr>", "Delete Buffer" },
}

lvim.builtin.which_key.mappings["w"] = {
  name = "+Windows",
  w = { "<C-w><C-w>", "Switch" },
  l = { "<C-w><C-l>", "Go Left" },
  h = { "<C-w><C-h>", "Go Right" },
  k = { "<C-w><C-k>", "Go Up" },
  j = { "<C-w><C-j>", "Go Down" },
  v = { "<C-w><C-j>", "Vertical Split" },
  s = { "<C-w><C-j>", "Split" },
  q = { "<C-w>q", "Delete window" },
}

lvim.builtin.which_key.mappings["s"] = {
  name = "+Search",
  b = { "<cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<cr>", "Switch" },
  }

lvim.keys.normal_mode["<Space>w"]="<C-w>"
lvim.keys.normal_mode["<Space>wl"]="<C-l>"
lvim.keys.normal_mode["<Space>wh"]="<C-h>"
lvim.keys.normal_mode["<Space>wk"]="<C-w>k"
lvim.keys.normal_mode["<Space>wj"]="<C-w>j"
lvim.keys.normal_mode["<Space>wd"]="<cmd>q<cr>"
lvim.keys.normal_mode["<Space>wv"]="<cmd>vsplit<cr>"
lvim.keys.normal_mode["<Space>ws"]="<cmd>split<cr>"
lvim.keys.normal_mode["gD"] ="<cmd>Telescope lsp_references<CR>"
lvim.keys.normal_mode["<Space>*"] ="<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>."] = "<cmd>Buffer_dir()<CR>"
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

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


-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"}, {
--         "ray-x/lsp_signature.nvim",
--         config = function() require"lsp_signature".on_attach() end,
--         event = "InsertEnter"
--     }
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
