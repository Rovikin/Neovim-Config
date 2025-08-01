return {
  -- Lazy
  {
    "nvim-lua/plenary.nvim"
  },

  -- Treesitter (highlight dan indent pintar)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "css", "javascript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Indent guide
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- File explorer (kayak sidebar di VSCode)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- ikon file
    },
    config = function()
      require("nvim-tree").setup()
      -- Shortcut CTRL+n buat toggle file explorer
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },
}

