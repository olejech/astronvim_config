return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.winbar = {
      static = {
        disabled = {
          buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
          filetype = { "NvimTree", "neo-tree", "dashboard", "Outline", "aerial" },
        },
      },
      status.component.file_info {
        filename = { modify = ":." },
        file_icon = false,
      },
    }
    opts.statusline = {
      hl = { bg = "#222732" },
      status.component.git_branch(),
      status.component.diagnostics(),
      status.component.cmd_info(),
    }
    return opts
  end,
}
