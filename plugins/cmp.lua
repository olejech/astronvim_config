return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp_status_ok, cmp = pcall(require, "cmp")
    local lspkind_status_ok, lspkind = pcall(require, "lspkind")
    opts.experimental = {
      ghost_text = true,
    }
    opts.formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
        },
      },
    }
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
    return opts
  end,
}
