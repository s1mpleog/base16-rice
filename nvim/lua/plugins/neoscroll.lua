-- lua/plugins/neoscroll.lua
return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      hide_cursor = false,
      stop_eof = true,
      duration_multiplier = 0.5,  -- lower = faster scroll animation, 1.0 is default
      easing = "sine",            -- sine, circular, quadratic, cubic, quartic, quintic, circular
      pre_hook  = nil,
      post_hook = nil,
    },
  },
}
