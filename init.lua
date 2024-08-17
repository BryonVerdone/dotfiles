vim.g.mapleader = " "
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
--vim:.cmd("set clipboard+=unnamedplus")
-- lazy package manager installation

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Add plugins
local plugins = {
	{"catppuccin/nvim", name = "catppuccin", priority = 1000},
	{'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = {'nvim-lua/plenary.nvim'}
},

{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
}
}

local opts = {}


require("lazy").setup(plugins, opts)

-- load telescope
local builtin = require("telescope.builtin")

-- set keymap to crtl+p
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

-- Need ripgrep install for live grep to work
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
require("catppuccin").setup()

-- treesitter setup
local config = require('nvim-treesitter.configs')
	config.setup({
	insure_installed = {"lua", "javascript"},
	highlight = {enabled = true},
	indent = {enabled = true},
})
vim.cmd.colorscheme "catppuccin"

-- Neotree key maps

vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal left<CR>', {})


