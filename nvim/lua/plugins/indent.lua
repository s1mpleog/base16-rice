return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope  = { enabled = true },  -- highlights the current scope's indent column
      exclude = {
        filetypes = { "help", "neo-tree", "lazy", "mason" },
      },
    },
  },
}
