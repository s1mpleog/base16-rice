return {
  {
    "echasnovski/mini.statusline",
    version = "*",
    event = "VeryLazy",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git           = statusline.section_git({ trunc_width = 75 })
            local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
            local filename      = statusline.section_filename({ trunc_width = 140 })
            local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
            local location      = statusline.section_location({ trunc_width = 75 })

            return statusline.combine_groups({
              { hl = mode_hl,          strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
              "%<",  -- truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",  -- right align everything after this
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl,          strings = { location } },
            })
          end,
        },
      })
    end,
  },
}
