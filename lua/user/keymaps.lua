local keymap = vim.api.nvim_set_keymap

local opts = {noremap = true, silent = true}

keymap('n', "<C-l>", ":BufferLineCycleNext<CR>", opts)
keymap('n', "<C-h>", ":BufferLineCyclePrev<CR>", opts)
keymap('n', "<leader>be", ":BufferLineSortByExtension<CR>", opts)
keymap('n', "<leader>bd", ":BufferLineSortByDirectory<CR>", opts)
keymap('n', "<leader>t", ":NvimTreeToggle<CR>", opts)
keymap('n', "<leader>s", ":SymbolsOutline<CR>", opts)

keymap('n', "\\1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap('n', "\\2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap('n', "\\3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap('n', "\\4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap('n', "\\5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap('n', "\\6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap('n', "\\7", ":BufferLineGoToBuffer 7<CR>", opts)
keymap('n', "\\8", ":BufferLineGoToBuffer 8<CR>", opts)
keymap('n', "\\9", ":BufferLineGoToBuffer 9<CR>", opts)
