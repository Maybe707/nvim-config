require('plugins')

require'lspconfig'.clangd.setup{}

vim.o.number=true
vim.o.swapfile=false 
vim.o.backup=false
vim.o.termguicolors=true
vim.o.guicursor="a:blinkon100"
vim.cmd ("map  <Leader>df <Plug>(easymotion-bd-f)")
-- vim.cmd ("guicursor=a:blinkon0")
-- vim.cmd ("colorscheme monokai")
require('monokai').setup {}
-- require('monokai').setup { palette = require('monokai').pro }
-- require('monokai').setup { palette = require('monokai').soda }

-- map  <Leader>f <Plug>(easymotion-bd-f)
-- nmap <Leader>f <Plug>(easymotion-overwin-f)

-- nmap s <Plug>(easymotion-overwin-f2)

-- map <Leader>L <Plug>(easymotion-bd-jk)
-- nmap <Leader>L <Plug>(easymotion-overwin-line)

-- map  <Leader>w <Plug>(easymotion-bd-w)
-- nmap <Leader>w <Plug>(easymotion-overwin-w)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.api.nvim_set_keymap('n', '<space>sd', [[<cmd>lua require('telescope.builtin').file_browser()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
-- :nnoremap <silent> <leader><Space> :set hlsearch<CR>

vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

local noerr, treesitter = pcall(require, 'nvim-treesitter.configs')

if not noerr then
    return
end

treesitter.setup{
    highlight = {
        enable = true,
        use_languagetree = true
    },
    ensure_installed = { 'lua', 'c', 'cpp'}
}
