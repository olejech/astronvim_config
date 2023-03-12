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
    return opts
  end,
}
