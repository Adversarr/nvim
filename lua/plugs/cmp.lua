local cmp = require("user.utils").load_plug("cmp")


if cmp == nil then
  return
end

local function has_words_before()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1]
  local col = cursor[2]
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
    -- completeopt = 'menu,menuone'
  },
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)     -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- mapping = cmp.mapping.preset.insert({
  --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --   ['<tab>'] = cmp.mapping.select_next_item(),
  --   ['<S-tab>'] = cmp.mapping.select_prev_item(),
  --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --   ['<C-Space>'] = cmp.mapping.complete(),
  --   ['<C-e>'] = cmp.mapping.abort(),
  --   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  -- }),

  -- 快捷键
  mapping = {
    -- 上一个
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- 出现补全
    -- ['<C-j>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    -- ['<C-k>'] = cmp.mapping({
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    -- }),
    -- RIME 专用确认
    -- ['<Space>'] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         cmp.mapping.confirm({
    --             select = true,
    --             behavior = cmp.ConfirmBehavior.Replace,
    --         })
    --     else
    --         fallback()
    --     end
    -- end, { 'i', 's' }),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Insert,
    }),

    -- ['<Space>'] = cmp.mapping.confirm({
    --     select = false,
    --     behavior = cmp.ConfirmBehavior.Insert,
    -- }),
    -- ['<C-Space>'] = cmp.mapping.disable,
    -- ['<CR>'] = cmp.mapping({
    --     i = cmp.mapping.abort(),
    --     c = cmp.mapping.close(),
    -- }),

    -- ['1'] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         cmp.mapping.confirm({
    --             select = true,
    --             behavior = cmp.ConfirmBehavior.Replace,
    --         })
    --     else
    --         fallback()
    --     end
    -- end),
    -- ['2'] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         cmp.select_next_item()
    --     else
    --         fallback()
    --     end
    -- end, { "i", "s" }),
    -- ['3'] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         cmp.select_next_item()
    --         cmp.select_next_item()
    --     else
    --         fallback()
    --     end
    -- end, { "i", "s" }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' },   -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' }
  })
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
