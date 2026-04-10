return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",  -- only loads when you enter insert mode
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,  -- use treesitter to know when NOT to pair (e.g. inside strings)
      })
      -- Make it work with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
