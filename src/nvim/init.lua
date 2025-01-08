--
-- Basics
--
vim.scriptencoding = "utf-8"
vim.opt.fileencodings = "utf-8"
vim.opt.fileformats = { "unix", "dos" }
vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.showcmd = true

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.virtualedit = "onemore"
vim.opt.smartindent = true
vim.opt.visualbell = true
vim.opt.showmatch = true
vim.opt.laststatus = 2
vim.opt.wildmode = "list:longest"
vim.opt.title = true

vim.opt.list = true
vim.opt.listchars = "tab:> ,"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true
vim.opt.autoindent = false

vim.opt.ambiwidth = "double"
vim.opt.matchtime = 1
vim.opt.ruler = true
vim.opt.number = true
vim.opt.autowrite = true
vim.opt.scrolloff = 5
vim.opt.history = 1000
vim.opt.wrap = false
vim.opt.wildmenu = true
vim.opt.wildchar = ('\t'):byte()
vim.opt.complete:append("k")
vim.opt.lazyredraw = true
vim.opt.backspace = { "indent", "eol", "start" }

vim.keymap.set('n', ';', ':')
vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohlsearch<CR><ESC>', { noremap = true, silent = true })

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

if not vim.fn.has("gui_running") then
  vim.opt.t_Co = 256
end

--
-- Paths
--
vim.g.ruby_host_prog = vim.fn.expand("~/.asdf/shims/neovim-ruby-host")
vim.g.node_host_prog = vim.fn.expand("~/.asdf/shims/neovim-node-host")
vim.g.python3_host_prog = vim.fn.expand('~/.asdf/shims/python')

--
-- Lazy Plugin Manager
--
require("config.lazy")
