return {
  plugin = {
    "RRethy/base16-nvim",
    lazy = false,    -- Load immediately so colors are set from the start
    priority = 1000, -- Load before everything else
    config = function()
      -- RRethy/base16-nvim config
      require("base16-colorscheme").with_config({
        telescope        = true,
        indentblankline  = true,
        notify           = true,
        cmp              = true,
        illuminate       = true,
        dapui            = true,
      })

      -- Activate Atelier Dune Dark
      -- The scheme name maps directly to the built-in list
      vim.cmd.colorscheme("base16-atelier-dune")
    end,
  },
  name = "base16-atelier-dune",
}
