return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 400,  -- show after 400ms of waiting, not instant
      icons = { mappings = true },
      spec = {
        { "<leader>f",  group = "find/telescope" },
        { "<leader>b",  group = "buffer" },
        { "<leader>d",  group = "diagnostics" },
        { "<leader>t",  group = "terminal" },
        { "<leader>r",  group = "rename" },
        { "<leader>c",  group = "code actions" },
        { "<leader>g",  group = "git" },
      },
    },
  },
}
