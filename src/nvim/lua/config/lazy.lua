-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    -- { import = "plugins" },
    {
      'cocopon/iceberg.vim',
      config = function()
        vim.cmd('colorscheme iceberg')
      end,
    },
    {
      'vim-airline/vim-airline',               -- vim-airline のリポジトリ
      dependencies = { 'gkeep/iceberg-dark' }, -- オプションでテーマも追加
      config = function()
        vim.g.airline_theme = 'icebergDark'
      end,
    },
    {
      'airblade/vim-gitgutter',
      config = function()
        vim.opt.updatetime = 250
        vim.cmd('hi GitGutterAdd ctermfg=darkgreen')
        vim.cmd('hi GitGutterChange ctermfg=yellow')
        vim.cmd('hi GitGutterDelete ctermfg=darkred')
      end
    },
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp', -- LSP ソース
        'hrsh7th/cmp-path',     -- ファイルパス補完
        'hrsh7th/cmp-buffer',   -- バッファ補完
        'hrsh7th/cmp-vsnip',    -- スニペット補完
        'hrsh7th/vim-vsnip',    -- スニペットエンジン
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- スニペット設定
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enterで補完確定
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' }, -- LSPを使った補完
            { name = 'path' },     -- ファイルパス補完
            { name = 'buffer' },   -- バッファ補完
          }),
        })
      end,
    },
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('lspconfig').ts_ls.setup({}) -- TypeScript用LSP
      end,
    },
    -- { 'vim-syntastic/syntastic' },
    -- { 'editorconfig/editorconfig-vim' },
    -- { 'leafgarland/typescript-vim' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
