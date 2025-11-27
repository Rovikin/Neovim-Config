-- =========================
-- INIT.LUA TERMUX SAFE + COPILOT + NvimTree + IndentLine (ibl terbaru)
-- =========================

-- 1️⃣ Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.signcolumn = 'yes'
vim.opt.numberwidth = 1
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = { tab = '│ ', trail = '·' }

-- 2️⃣ Leader key
vim.g.mapleader = " "

-- 3️⃣ Plugin manager (packer.nvim)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'github/copilot.vim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'

  -- Treesitter optional (hapus run, biar aman)
  use { 'nvim-treesitter/nvim-treesitter' }

  -- Indent-blankline (ibl terbaru)
  use {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│", tab_char = "│" },
        exclude = { filetypes = { "help", "alpha", "dashboard", "neo-tree", "toggleterm" } }
      })
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- 4️⃣ Treesitter safe setup (pcall biar gak crash)
pcall(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "python", "bash" },
    highlight = { enable = true },
    indent = { enable = true },
  }
end)

-- 5️⃣ NvimTree setup
require('nvim-tree').setup({
  view = { width = 30, side = 'left' },
  renderer = { indent_markers = { enable = true } },
  update_focused_file = { enable = true },
})

-- 6️⃣ Keymaps
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<C-x>', ':bd<CR>')
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('n', '<C-q>', ':q<CR>')
vim.keymap.set('n', '<C-h>', ':noh<CR>')
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>') -- toggle NvimTree

vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a')
vim.keymap.set('i', '<C-i>', 'copilot#Accept("<CR>")', { expr = true, silent = true }) -- Copilot accept

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Accept suggestion dengan spasi panjang
vim.keymap.set('i', '<Space>', function()
  local col = vim.fn.col('.') - 1
  local line = vim.fn.getline('.')
  if col > 0 and line:sub(col, col) == ' ' then
    return vim.fn["copilot#Accept"]()
  else
    return ' '
  end
end, { expr = true, noremap = true })

-- =========================
-- DONE
-- =========================
