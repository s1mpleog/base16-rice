local opt = vim.opt

-- Make leader space before anything else loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- === 180hz / performance tuning ===
opt.updatetime = 50       -- CursorHold fires after 50ms idle (default 4000ms — kills LSP responsiveness)
opt.timeoutlen = 300      -- Faster key sequence resolution
opt.lazyredraw = false    -- DO NOT set true — breaks many plugins and actually causes visual stutters
opt.ttyfast = true        -- Tell Vim we have a fast terminal (usually auto-detected, but explicit)
opt.synmaxcol = 300       -- Stop syntax highlighting beyond col 300 (prevents lag on minified files)
opt.redrawtime = 1500     -- If highlighting takes longer than 1500ms, stop and show plain text

-- Scrolling smoothness
opt.scrolloff = 8         -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8

-- === Editor ===
opt.number = true
opt.relativenumber = true
opt.cursorline = true     -- Highlight current line
opt.wrap = false          -- No line wrap — essential for wide C++ templates
opt.signcolumn = "yes"    -- Always show, prevents layout shift when diagnostics appear
opt.colorcolumn = "120"

-- === Indentation ===
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- === Search ===
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false      -- Don't keep search highlights after you're done
opt.incsearch = true

-- === Splits ===
opt.splitright = true     -- New vertical splits go right
opt.splitbelow = true     -- New horizontal splits go below

-- === Appearance ===
opt.termguicolors = true  -- 24-bit RGB — required for most colorschemes
opt.showmode = false      -- Mode is shown in statusline, not needed in cmdline
opt.cmdheight = 1
opt.pumheight = 10        -- Max 10 items in completion popup
opt.conceallevel = 0

-- === Files ===
opt.undofile = true       -- Persistent undo across sessions
opt.swapfile = false
opt.backup = false
opt.fileencoding = "utf-8"

-- === Clipboard ===
opt.clipboard = "unnamedplus"  -- Use system clipboard

-- === Completion ===
opt.completeopt = { "menuone", "noselect" }
opt.shortmess:append("c")     -- Don't show "match N of M" noise in completion

-- Keep your cursor position when switching buffers
opt.jumpoptions = "view"

-- Show which line your cursor is on across splits more clearly
opt.cursorlineopt = "number"  -- only highlight the number, not the whole line (less visual noise)

-- Smarter command line completion
opt.wildmode = "longest:full,full"

-- Don't jump to matching bracket when typing — annoying at 180hz
opt.showmatch = false

-- Persist the undo history across sessions (you already have undofile=true,
-- but make sure the directory exists)
local undodir = vim.fn.stdpath("data") .. "/undodir"
if not vim.loop.fs_stat(undodir) then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir
opt.undolevels = 10000  -- 10000 undo steps


vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- When jumping to a file from telescope or LSP, 
-- always open it in the existing window instead of a new split
opt.switchbuf = "useopen,uselast"
