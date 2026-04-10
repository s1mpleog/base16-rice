vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("core.options")
require("core.keymaps")

-- Pull the active theme's plugin spec
local theme = require("themes.active")

require("lazy").setup({
  -- Spread the theme plugin spec in as the first entry
  theme.plugin,
  -- Then load everything else from the plugins/ folder
  { import = "plugins" },
}, {
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
--"man",           -- you don't read man pages in nvim
  "osc52",         -- clipboard over SSH, you're on WSL not SSH
  "rplugin",       -- remote plugins, you have none
  "shada",         -- shared data file, only needed if you care about cross-session marks
  "spellfile",     -- spellcheck downloader, you're not using spellcheck
      },
    },
  },
})
