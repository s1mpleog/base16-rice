return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- Only load when you enter insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",    -- LSP completions
      "hrsh7th/cmp-buffer",      -- Words from current buffer
      "hrsh7th/cmp-path",        -- Filesystem paths
      -- Snippet engine (required by nvim-cmp)
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "saadparwaiz1/cmp_luasnip" },
      },
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]   = cmp.mapping.select_next_item(),
          ["<C-p>"]   = cmp.mapping.select_prev_item(),
          ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]   = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]   = cmp.mapping.abort(),
          ["<CR>"]    = cmp.mapping.confirm({ select = false }),  -- Only confirm explicitly selected
          ["<Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
        }),
        formatting = {
          format = function(entry, item)
            local source_names = {
              nvim_lsp = "[LSP]",
              buffer   = "[Buf]",
              path     = "[Path]",
              luasnip  = "[Snip]",
            }
            item.menu = source_names[entry.source.name] or ""
            return item
          end,
        },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = false,  -- Show inline preview of first completion
        },
      })
    end,
  },
}
