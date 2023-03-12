return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      lsp_definitions = {
        file_ignore_patterns = { "index.d.ts" },
      },
      find_files = {
        hidden = true,
        file_ignore_patterns = { ".git/", "index.ts", "%.lock" },
      },
      live_grep = {
        file_ignore_patterns = { ".git/", "%.lock", "%.svg" },
      },
    },
  },
}
