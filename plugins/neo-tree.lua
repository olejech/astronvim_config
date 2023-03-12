return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    add_blank_line_top = false,
    filesystem = {
      window = {
        mappings = {
          ["/"] = "noop",
          ["g/"] = "fuzzy_finder",
        },
      },
    },
  },
}
