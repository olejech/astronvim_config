local config = {
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
  },

  colorscheme = "melange",

  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    },
  },

  default_theme = {
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  diagnostics = {
    virtual_text = true,
    underline = true,
    update_in_insert = false,
  },

  lsp = {
    formatting = {
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
      },
      timeout_ms = 1000, -- default format timeout
    },
    ["server-settings"] = {
      stylelint_lsp = {
        filetypes = {
          "css",
          "scss",
        },
      },
      tsserver = require "user.lsp.tsserver",
    },
    mappings = {
      n = {
        ["<leader>lr"] = { function() require("telescope.builtin").lsp_references() end, desc = "Telescope references" },
        ["<leader>lR"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" },
      },
    },
  },

  mappings = {
    n = {
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      ["<leader>j"] = { "o<ESC>", desc = "Insert new line below" },
      ["<leader>k"] = { "O<ESC>", desc = "Insert new line above" },
      ["<leader>js"] = { "<cmd>JestSingle<cr>", desc = "Jest single" },
      ["<leader>ja"] = { "<cmd>Jest<cr>", desc = "Jest all" },
      ["<leader>jf"] = { "<cmd>JestFile<cr>", desc = "Jest file" },
      ["<leader>ll"] = {
        "\"ayiwoconsole.log('<c-r>=expand('%:t:r')<cr> —> <C-R>a:', <C-R>a);<Esc>",
        desc = "Console log",
      },
    },
  },

  plugins = {
    init = {
      {
        "savq/melange",
      },
      {
        "mattkubej/jest.nvim",
        config = function()
          require("nvim-jest").setup {
            jest_cmd = "yarn test",
          }
        end,
      },
    },
    ["neo-tree"] = {
      filesystem = {
        window = {
          mappings = {
            ["/"] = "noop",
            ["g/"] = "fuzzy_finder",
          },
        },
      },
    },
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      local null_ls = require "null-ls"

      config.sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
      }
      return config
    end,
    treesitter = {
      rainbow = {
        enable = false,
      },
    },
    heirline = function(config)
      config[2] = {
        {
          condition = function()
            return astronvim.status.condition.buffer_matches {
              buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
              filetype = { "NvimTree", "neo-tree", "dashboard", "Outline", "aerial" },
            }
          end,
          init = function() vim.opt_local.winbar = nil end,
        },
        astronvim.status.component.file_info {
          filename = { modify = ":." },
          file_icon = false,
        },
      }
      return config
    end,
    telescope = {
      pickers = {
        find_files = {
          hidden = true,
          file_ignore_patterns = { ".git/", "index.ts", "%.lock" },
        },
        live_grep = {
          file_ignore_patterns = { ".git/", "%.lock", "%.svg" },
        },
      },
    },
    alpha = function(config)
      table.insert(config.layout[4].val, 1, astronvim.alpha_button("LDR S f", "  Sessions"))

      return config
    end,
    bufferline = {
      options = {
        sort_by = "insert_after_current",
      },
    },
  },

  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  ["which-key"] = {
    register = {
      n = {
        ["<leader>"] = {
          ["b"] = { name = "Buffer" },
          ["j"] = { name = "Jest" },
        },
      },
    },
  },

  header = { "" },
}

return config
