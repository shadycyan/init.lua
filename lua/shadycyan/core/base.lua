vim.cmd("autocmd!")

vim.wo.number = true

local opt = vim.opt

vim.opt.guicursor = ""

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.title = true
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.scrolloff = 8
opt.shell = 'zsh'
opt.inccommand = 'split'
opt.breakindent = true
opt.path:append { '**' } -- finding files - search down into subfolders
opt.wildignore:append { '*/node_modules/*' }
opt.isfname:append("@-@")

opt.updatetime = 50

opt.hlsearch = true
opt.incsearch = true

-- line numbers
opt.relativenumber = false -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = false -- no expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- backspace
opt.backspace = { 'start', 'eol', 'indent' } -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

opt.backup = false
opt.backupskip = { '/tmp/*', '/private/tmp/*' }

-- add asterisks in block comments
opt.formatoptions:append { 'r' }

-- undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})
