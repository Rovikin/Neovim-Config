-- ========================
-- 🚀 Lazy.nvim Bootstrapper
-- ========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ========================
-- 🔌 Plugins
-- ========================
require("lazy").setup("plugins")

-- ========================
-- ⚙️ Basic Options
-- ========================
local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"

-- Text Wrapping & Indent
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.smartindent = true

-- Encoding & File
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Scrolling & Navigation
opt.scrolloff = 5
opt.sidescrolloff = 5

-- Mouse & Clipboard
opt.mouse = "a"               -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Splits behavior
opt.splitright = true
opt.splitbelow = true

-- UI Timing
opt.timeoutlen = 500
opt.updatetime = 300

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Backups & Undo
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Appearance
opt.showmode = false
opt.cmdheight = 1
opt.laststatus = 3
opt.pumheight = 10
opt.conceallevel = 2
opt.wrap = true

-- Highlight baris lanjutan
opt.showbreak = "↳ "

-- Theme fallback if any
pcall(vim.cmd, "colorscheme gruvbox") -- bisa diganti sesuai plugin lu

-- ========================
-- 🧹 Autocommand Example
-- ========================
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
