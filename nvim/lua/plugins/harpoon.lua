-- lua/plugins/harpoon.lua
return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = "nvim-lua/plenary.nvim",
        keys = function()
            local harpoon = require("harpoon")
            return {
                { "<leader>ha", function() harpoon:list():add() end,                         desc = "Harpoon add file" },
                { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
                -- jump directly to mark 1-4
                { "<leader>h1", function() harpoon:list():select(1) end,                     desc = "Harpoon file 1" },
                { "<leader>h2", function() harpoon:list():select(2) end,                     desc = "Harpoon file 2" },
                { "<leader>h3", function() harpoon:list():select(3) end,                     desc = "Harpoon file 3" },
                { "<leader>h4", function() harpoon:list():select(4) end,                     desc = "Harpoon file 4" },
            }
        end,
        config = function()
            require("harpoon"):setup()
        end,
    },
}
