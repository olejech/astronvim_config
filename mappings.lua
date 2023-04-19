-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>j"] = { "o<ESC>", desc = "Insert new line below" },
    ["<leader>k"] = { "O<ESC>", desc = "Insert new line above" },
    ["<leader>js"] = { "<cmd>JestSingle<cr>", desc = "Jest single" },
    ["<leader>ja"] = { "<cmd>Jest<cr>", desc = "Jest all" },
    ["<leader>jf"] = { "<cmd>JestFile<cr>", desc = "Jest file" },
    ["<leader>ll"] = {
      "\"ayiwoconsole.log('<c-r>=expand('%:t:r')<cr> —> <C-R>a:', <C-R>a);<Esc>",
      desc = "Console log",
    },
    ["<leader>to"] = { "<cmd>MindOpenProject global<cr>", desc = "Open todos" },
    ["<leader>gb"] = { "<cmd>Telescope git_bcommits<cr>", desc = "Commits buffer" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {
    ["<C-c>["] = {
      function() return vim.fn["codeium#CycleCompletions"](-1) end,
      desc = "Prev suggestion Codeium",
      expr = true,
    },
    ["<C-c>]"] = {
      function() return vim.fn["codeium#CycleCompletions"](1) end,
      desc = "Next suggestion Codeium",
      expr = true,
    },
    ["<C-c><CR>"] = {
      function() return vim.fn["codeium#Accept"]() end,
      desc = "Apply suggestion Codeium",
      expr = true,
    },
  },
}
