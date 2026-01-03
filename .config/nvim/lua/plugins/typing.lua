return {
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-repeat",
    },
    config = function()
      require("leap")
    end,
  },
  {

    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.operators").setup({
        exchange = {
          prefix = "gX",

          reindent_linewise = true,
        },
      })
      require("mini.bracketed").setup()
      require("mini.move")
      require("mini.extra").setup()
      require("mini.clue").setup()
      require("mini.indentscope").setup()
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
    },
  },
  {

    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.operators").setup({
        exchange = {
          prefix = "gX",

          reindent_linewise = true,
        },
      })
      require("mini.bracketed").setup()
      require("mini.extra").setup()
      require("mini.clue").setup()
      require("mini.move").setup()
      require("mini.indentscope").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true,           -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ["html"] = {
            enable_close = false,
          },
        },
      })
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      --zathura is for linux, skim for macos
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
        callback = 1,
        options = {
          '-pdf',
          '-shell-escape',
          '-interaction=nonstopmode',
          '-synctex=1',
        }
      }
    end
  },
  {
    "sindrets/diffview.nvim",
    init = function()
      require("diffview").setup()
    end
  },
}
-- vim: ts=2 sts=2 sw=2 et
