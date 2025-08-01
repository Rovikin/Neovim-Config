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
      -- Keymap ini gw biarin di sini aja biar ga duplikat di init.lua
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- Telescope (Penting buat GitHub Repo Picker lu!)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x", -- Atau bisa pake branch 'master'
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        -- Konfigurasi Telescope lu di sini (opsional, bisa ditambah nanti)
        defaults = {
          mappings = {
            i = {
              -- Contoh mapping, bisa disesuaikan
              -- ["<C-j>"] = "move_selection_next",
              -- ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
    end,
  },
}
