return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",  -- icons (requires a Nerd Font — you already have one)
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",   -- Lazy-load
    keys = {
      { "<leader>e",  "<cmd>Neotree toggle<cr>",        desc = "Toggle file tree" },
      { "<leader>fe", "<cmd>Neotree focus<cr>",         desc = "Focus file tree" },
      { "<leader>ge", "<cmd>Neotree git_status<cr>",    desc = "Git status tree" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
          width = 30,
          mappings = {
            ["<space>"] = "none",  -- Don't conflict with leader
            ["P"] = { "toggle_preview", config = { use_float = true } },
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,   -- Show dotfiles
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true,          -- Auto-reveal current file in tree
          },
          use_libuv_file_watcher = true,  -- OS-level file watching (no polling)
        },
        default_component_configs = {
          indent = { indent_size = 2 },
          icon = {
            folder_closed = "",
            folder_open   = "",
            folder_empty  = "󰜌",
          },
          git_status = {
            symbols = {
              added     = "✚",
              modified  = "",
              deleted   = "✖",
              renamed   = "󰁕",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            },
          },
        },
      })
    end,
  },
}