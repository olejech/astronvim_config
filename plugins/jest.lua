return {
  "mattkubej/jest.nvim",
  lazy = false,
  config = function()
    require("nvim-jest").setup {
      jest_cmd = "yarn test",
    }
  end,
}
