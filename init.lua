vim.g.mapleader = " "
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
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

local plugins = {
	{"catppuccin/nvim", name = "catppuccin", priority = 1000},
	{'nvim-telescope/telescope.nvim', tag = '0.1.8',

	dependencies = {'nvim-lua/plenary.nvim'}
}
}

local opts = {}


require("lazy").setup(plugins, opts)
-- load telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- Need ripgrep install for live grep to work
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
require("catppuccin").setup()

vim.cmd.colorscheme "catppuccin"




