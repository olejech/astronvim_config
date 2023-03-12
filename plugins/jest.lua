return {
  "mattkubej/jest.nvim",
  config = function()
    require("nvim-jest").setup {
      jest_cmd = "yarn test",
    }
  end,
}
