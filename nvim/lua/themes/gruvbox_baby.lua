return {
  plugin = {
    "luisiacc/gruvbox-baby",
    lazy = false,     -- Load immediately, not on demand
    priority = 1000,  -- Load before everything else so colors are right from the start
    config = function()
      -- Gruvbox baby config must be set BEFORE calling colorscheme
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_keyword_style  = "NONE"
      vim.g.gruvbox_baby_comment_style  = "NONE"
      vim.g.gruvbox_baby_highlights     = {}  -- Override specific highlights here if needed

      -- Background: "dark" or "medium" or "hard"
      vim.g.gruvbox_baby_background_color = "dark"

      -- Telescope integration
      vim.g.gruvbox_baby_telescope_theme = 1

      vim.cmd.colorscheme("gruvbox-baby")
    end,
  },
  -- Name used in active.lua for display purposes only
  name = "gruvbox-baby",
}
