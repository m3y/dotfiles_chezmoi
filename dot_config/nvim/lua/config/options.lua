local opt = vim.opt

-- tab and indent
opt.list = true
opt.listchars = "tab:_ "
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- Display
opt.number = true
opt.title = false
opt.cmdheight = 0
opt.laststatus = 0
opt.statusline = "-"
opt.fillchars:append({ stl = "-", stlnc = "-" })
opt.splitright = true

-- Searching
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Other
opt.swapfile = false
opt.hidden = true
opt.autoread = true
