local utils = require('user.utils')
local wk = utils.load_plug('which-key')
if wk == nil then
  return
end

local reg = wk.register
local add = wk.add

local function try_close_buffer(kill_command, bufnr, force)
  kill_command = kill_command or "bd"
  -- Reference: https://github.com/LunarVim/LunarVim/lua/lvim/core/bufferline.lua

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fnamemodify = vim.fn.fnamemodify

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local warning
    if bo[bufnr].modified then
      warning = fmt([[No write since last change for (%s)]], fnamemodify(bufname, ":t"))
    elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      warning = fmt([[Terminal %s will be killed]], bufname)
    end
    if warning then
      vim.ui.input({
        prompt = string.format([[%s. Close it anyway? [y]es or [n]o (default: no): ]], warning),
      }, function(choice)
        if choice:match "ye?s?" then force = true end
      end)
      if not force then return end
    end
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and (#buffers - 1) or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end



-- SECT: Normal mode, without prefix:
add({
  { "<C-s>",     "<cmd>w<cr>",                               desc = "Write file" },
  { "<C-Down>",  "<cmd>resize -2<cr>",                       desc = "Decrease window height" },
  { "<C-H>",     "<c-w>h",                                   desc = "Jump to window left" },
  { "<C-J>",     "<c-w>j",                                   desc = "Jump to window bottom" },
  { "<C-K>",     "<c-w>k",                                   desc = "Jump to window up" },
  { "<C-L>",     "<c-w>l",                                   desc = "Jump to window right" },
  { "<C-Left>",  "<cmd>vertical resize +2<cr>",              desc = "Increase window width" },
  { "<C-Right>", "<cmd>vertical resize -2<cr>",              desc = "Decrease window width" },
  -- Idea comes from lunarvim:
  { "<C-Up>",    "<cmd>resize +2<cr>",                       desc = "Increase window height" },
  { "<M-1>",     "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Term default." },
  { "<M-2>",     "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Term vertical." },
  { "<M-3>",     "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Term float." },
  { "<M-c>",     try_close_buffer,                           desc = "Quit the window" },
  { "<M-h>",     "<cmd>BufferLineCyclePrev<cr>",             desc = "Prev buffer" },
  { "<M-j>",     "<cmd>move .+1<cr>==",                      desc = "Move current line +1" },
  { "<M-k>",     "<cmd>move .-2<cr>==",                      desc = "Move current line -2" },
  { "<M-l>",     "<cmd>BufferLineCycleNext<cr>",             desc = "Next buffer" },
  { "<M-q>",     "<cmd>q<cr>",                               desc = "Quit the window" },
})

-- SECT: Editor in X mode
add {
  mode = { 'x' },
  { "<", "<gv", desc = "move left" },
  { ">", ">gv", desc = "move right" },
  { "<M-j>", ":move '>+1<cr>gv-gv",    desc = "Move current line +1", mode = "x" },
  { "<M-k>", ":move '<lt>-2<cr>gv-gv", desc = "Move current line -2", mode = "x" },
}


-- NOTE: For Terminal:
add {
  mode = { "t" },
  { "<M-1>", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Term default." },
  { "<M-2>", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Term vertical." },
  { "<M-3>", "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Term float." },
}

-- NOTE: <leader>
add {
  { "<leader>E",   "<cmd>NvimTreeFindFileToggle<cr>",                                desc = "Nvim Tree: Find File and Toggle" },
  { "<leader>q",   "<cmd>quit<cr>",                                                  desc = "Quit window" },
  { "<leader>w",   "<cmd>wa<cr>",                                                    desc = "Write all files" },
  { "<leader>e",   "<cmd>NvimTreeToggle<CR>",                                        desc = "Nvim Tree: Toggle" },
  { "<leader>f",   "<cmd>Telescope git_files<cr>",                                   desc = "Find Git File" },
  { "<leader>h",   "<cmd>nohl<cr>",                                                  desc = "Cancel search highlight" },

  -- SECT: buffer actions
  { "<leader>b",   group = "Buffer Actions" },
  { "<leader>bb",  "<cmd>BufferLineCyclePrev<cr>",                                   desc = "Prev buffer" },
  { "<leader>bc",  "<cmd>BufferLinePickClose<cr>",                                   desc = "Pick and close buffer" },
  { "<leader>bn",  "<cmd>BufferLineCycleNext<cr>",                                   desc = "Next buffer" },

  -- SECT: git actions
  { "<leader>g",   group = "Git" },
  { "<leader>gb",  "<cmd>Telescope git_branches<cr>",                                desc = "Git Branches" },
  { "<leader>gc",  "<cmd>Telescope git_commits<cr>",                                 desc = "Git Commits" },
  { "<leader>gf",  "<cmd>Telescope git_files<cr>",                                   desc = "Git Files" },
  { "<leader>gg",  group = "gitsigns" },
  { "<leader>ggD", "<cmd>Gitsigns diffthis<cr>",                                     desc = "Diff this" },
  { "<leader>ggb", "<cmd>Gitsigns toggle_current_line_blame<cr>",                    desc = "Toggle current line blame" },
  { "<leader>ggd", "<cmd>Gitsigns toggle_deleted<cr>",                               desc = "Toggle deleted" },
  { "<leader>ggl", "<cmd>Gitsigns toggle_linehl<cr>",                                desc = "Toggle line highlight" },
  { "<leader>ggn", "<cmd>Gitsigns toggle_numhl<cr>",                                 desc = "Toggle number highlight" },
  { "<leader>ggs", "<cmd>Gitsigns toggle_signs<cr>",                                 desc = "Toggle signs" },
  { "<leader>ggw", "<cmd>Gitsigns toggle_word_diff<cr>",                             desc = "Toggle word diff" },
  { "<leader>gp",  "<cmd>Telescope git_stash<cr>",                                   desc = "Git Stash" },
  { "<leader>gr",  "<cmd>Telescope git_bcommits<cr>",                                desc = "Git Commits" },
  { "<leader>gs",  "<cmd>Telescope git_status<cr>",                                  desc = "Git Status" },

  -- SECT: Lsp actions
  { "<leader>l",   group = "Lsp" },
  { "<leader>lD",  "<cmd>Telescope diagnostic<cr>",                                  desc = "Document Diagnostics" },
  { "<leader>lS",  "<cmd>Telescope lsp_workspace_symbols<cr>",                       desc = "Workspace Symbols" },
  { "<leader>ld",  "<cmd>TodoTrouble<cr>",                                           desc = "Todo lists." },
  { "<leader>lh",  "<cmd>ClangdSwitch<cr>",                                          desc = "Switch Source Header" },
  { "<leader>ln",  "<cmd>Neogen<cr>",                                                desc = "Neogen Doc String" },
  { "<leader>lo",  "<cmd>SymbolsOutline<cr>",                                        desc = "Symbols Outline" },
  { "<leader>lq",  vim.lsp.buf.code_action,                                          desc = "Code action" },
  { "<leader>ls",  "<cmd>Telescope lsp_document_symbols<cr>",                        desc = "Document Symbols" },
  { "<leader>lt",  "<cmd>Trouble diagnostics<cr>",                                   desc = "Document diagnostics" },

  -- SECT: Telescope actions
  { "<leader>t",   group = "Telescope Actions" },
  { "<leader>tP",  "<cmd>Telescope find_files find_command=rg,--hidden,--files<cr>", desc = "Files" },
  { "<leader>tb",  "<cmd>Telescope buffers<cr>",                                     desc = "Switch between buffers" },
  { "<leader>tp",  "<cmd>Telescope git_files show_untracked=true<cr>",               desc = "Git Files." },
  { "<leader>tt",  "<cmd>Telescope live_grep use_regex=true<cr>",                    desc = "Find string in ws" },


  -- SECT: Grug Far
  { "<leader>R", group = "Grug far"},

  -- Launch with the current word under the cursor as the search string
  --
  -- :lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
  { "<leader>Rw", function ()
    require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
  end, desc = "Current World" },
  --
  -- Launch with the current file as a flag, which limits search/replace to it
  --
  -- :lua require('grug-far').grug_far({ prefills = { flags = vim.fn.expand("%") } })
  { "<leader>Rf", function ()
    require('grug-far').grug_far({ prefills = { flags = vim.fn.expand("%") } })
  end, desc = "Current File" },

  -- Launch with the current visual selection, searching only current file
  --
  -- :<C-u>lua require('grug-far').with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
  { "<leader>Rv", function ()
    require('grug-far').with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
  end, desc = "Visual Selection" },
  -- Toggle visibility of a particular instance and set title to a fixed string
  --
  -- :lua require('grug-far').toggle_instance({ instanceName="far", staticTitle="Find and Replace" })
  { "<leader>Rt", function ()
    require('grug-far').toggle_instance({ instanceName="far", staticTitle="Find and Replace" })
  end, desc = "Toggle Instance" },
}

-- NOTE: Refactor
add {
  mode = {"n", "x"},
  {"<leader>rr", function() require('telescope').extensions.refactoring.refactors() end, desc='Refactor'},
  {"<leader>rn", function() require('telescope').extensions.refactoring.renames() end,   desc='Rename'},
}

add {
  mode = { 'x' },
  { "<leader>re", function() require('refactoring').refactor('Extract Function') end,         desc = "Extract Function" },
  { "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, desc = "Extract Function To File" },
  { "<leader>ri", function() require('refactoring').refactor('Inline Variable') end,          desc = "Inline Variable" },
  { "<leader>rv", function() require('refactoring').refactor('Extract Variable') end,         desc = "Extract Variable" },
}

add {
  mode = { 'n' },
  { "<leader>rb",  function() require('refactoring').refactor('Extract Block') end,           desc = "Extract Block" },
  { "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end,   desc = "Extract Block To File" },
  { "<leader>rI",  function() require('refactoring').refactor('Inline Function') end,         desc = "Inline Function" },
}

-- TODO: Dapui does not exists any more?

-- > and < will holdon in x-mode.
-- vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true })
-- vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true })


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local current_buffer = ev.buf

    local function format_code()
      vim.lsp.buf.format { async = true }
    end
    require('which-key').add {
      { "K",  vim.lsp.buf.hover,                      buffer = current_buffer,        desc = "Hover text." },
      { "g",  buffer = current_buffer,                             group = "Lsp goto" },
      { "gD", vim.lsp.buf.declaration,                buffer = current_buffer,        desc = "Goto declaration" },
      { "gd", vim.lsp.buf.definition,                 buffer = current_buffer,        desc = "Goto definition" },
      { "gi", "<cmd>Trouble lsp_implementations<cr>", buffer = current_buffer,        desc = "Goto implementation" },
      { "gr", "<cmd>Trouble lsp_references<cr>",      buffer = current_buffer,        desc = "Goto references" },
      { "<leader>lf",  format_code,                           buffer = current_buffer,                   desc = "Format code." },
      { "<leader>ll",  buffer = current_buffer,                            group = "Lsp list" },
      { "<leader>llI", "<cmd>Trouble lsp_incoming_calls<cr>", buffer = current_buffer,                   desc = "Incoming calls" },
      { "<leader>llO", "<cmd>Trouble lsp_outgoing_calls<cr>", buffer = current_buffer,                   desc = "Outgoing calls" },
      { "<leader>lli", vim.lsp.buf.implementation,            buffer = current_buffer,                   desc = "Goto implementation" },
      { "<leader>lr",  buffer = current_buffer,                            group = "Refactor and rename" },
      { "<leader>lre", vim.lsp.buf.code_action,               buffer = current_buffer,                   desc = "Code action Refactoring." },
      { "<leader>lrn", vim.lsp.buf.rename,                    buffer = current_buffer,                   desc = "Rename symbol" },
    }
  end,
})

local comment = utils.load_plug('Comment')
if comment ~= nil then
  add {
    { "gcc", comment.toggle, buffer = 1, desc = "Comment line" },
    { "gc",  comment.toggle, buffer = 1, desc = "Comment line" },
  }
end
