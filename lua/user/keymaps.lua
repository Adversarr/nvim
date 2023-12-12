-- TODO: Add comment keymap.

local utils = require('user.utils')
local wk = utils.load_plug('which-key')
if wk == nil then
  return
end

local reg = wk.register



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



-- Normal mode, without prefix:
reg {
  ["<C-s>"] = {
    "<cmd>w<cr>",
    "Write file"
  },
  -- Idea comes from lunarvim:
  ["<C-H>"] = { "<c-w>h", "Jump to window left" },
  ["<C-J>"] = { "<c-w>j", "Jump to window bottom" },
  ["<C-K>"] = { "<c-w>k", "Jump to window up" },
  ["<C-L>"] = { "<c-w>l", "Jump to window right" },
  ["<M-k>"] = { "<cmd>move .-2<cr>==", "Move current line -2" },
  ["<M-j>"] = { "<cmd>move .+1<cr>==", "Move current line +1" },
  ["<M-3>"] = { "<cmd>ToggleTerm direction=float<cr>", "Toggle Term float." },
  ["<M-q>"] = { "<cmd>q<cr>", "Quit the window" },
  ["<M-c>"] = { try_close_buffer, "Quit the window" },
  ["<M-h>"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev buffer" },
  ["<M-l>"] = { "<cmd>BufferLineCycleNext<cr>", "Next buffer" },
}

-- For Terminal:
reg({
  ["<M-1>"] = { "<cmd>ToggleTerm<cr>", "Toggle Term default." },
  ["<M-2>"] = { "<cmd>ToggleTerm direction=vertical<cr>", "Toggle Term vertical." },
  ["<M-3>"] = { "<cmd>ToggleTerm direction=float<cr>", "Toggle Term float." }
}, { mode = 't' })

reg({
  ["<M-k>"] = { ":move '<lt>-2<cr>gv-gv", "Move current line -2" },
  ["<M-j>"] = { ":move '>+1<cr>gv-gv", "Move current line +1" },
}, { mode = 'x' })


-- <leader>...
reg({
  -- name = "Toggle NvimTree",
  c = { try_close_buffer, "Close Buffer" },
  C = { "<cmd>w<CR><cmd>bd<cr>", "Write and close buffer" },
  f = { "<cmd>Telescope git_files<cr>", "Find Git File" },
  e = { "<cmd>NvimTreeToggle<CR>", "Nvim Tree: Toggle" },
  h = { "<cmd>nohl<cr>", "Cancel search highlight" },
  q = { "<cmd>quit<cr>", "Quit window" },
  w = { "<cmd>wa<cr>", "Write all files" },
  b = {
    name = "Buffer Actions",
    b = { "<cmd>BufferLineCyclePrev<cr>", "Prev buffer" },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next buffer" },
    c = { "<cmd>BufferLinePickClose<cr>", "Pick and close buffer" }
  },
  t = {
    name = "Telescope Actions",
    b = { "<cmd>Telescope buffers<cr>", "Switch between buffers" },
    p = { "<cmd>Telescope git_files show_untracked=true<cr>", "Git Files." },
    P = { "<cmd>Telescope find_files find_command=rg,--hidden,--files<cr>", "Files" },
    t = { "<cmd>Telescope live_grep use_regex=true<cr>", "Find string in ws" },
  },
  l = {
    name = "Lsp",
    q = { vim.lsp.buf.code_action, "Code action" },
    o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
    t = { "<cmd>Trouble document_diagnostics<cr>", "Document diagnostics" },
    d = { "<cmd>TodoTrouble<cr>", "Todo lists." },
    T = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace diagnostics" },
    k = { vim.lsp.diagnostic.goto_next, "Goto previous diagnostic" },
    j = { vim.lsp.diagnostic.goto_prev, "Goto next diagnostic" },
    D = { "<cmd>Telescope diagnostic<cr>", "Document Diagnostics" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols" },
    h = { "<cmd>ClangdSwitch<cr>", "Switch Source Header" },
    n = { "<cmd>Neogen<cr>", "Neogen Doc String" },
  }

}, { prefix = "<leader>" })


reg({
  name = 'Dap',
  o = { require("dapui").open, "Open DapUI" },
  c = { require('dapui').close, "Close DapUI" },
  d = { require('dapui').toggle, "Toggle DapUI" }

}, { prefix = '<leader>d' })


-- > and < will holdon in x-mode.
vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true })


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    reg({
      g = {
        name = "Lsp goto",
        D = { vim.lsp.buf.declaration, "Goto declaration" },
        d = { vim.lsp.buf.definition, "Goto definition" },
        i = { vim.lsp.buf.implementation, "Goto implementation" },
        t = { vim.lsp.buf.type_definition, "Goto definition." },
        r = { "<cmd>Trouble lsp_references<cr>", "Goto references" }
      },
      K = { vim.lsp.buf.hover, "Hover text." },
    }, {
      mode = 'n', buffer = ev.buf
    }
    )

    reg({
      l = {
        f = { function()
          vim.lsp.buf.format { async = true }
        end, "Format code." },
        r = {
          name = "Refactor and rename",
          n = { vim.lsp.buf.rename, "Rename symbol" },
          e = { vim.lsp.buf.code_action, "Code action Refactoring." }
        },
      },
      w = {
        a = { vim.lsp.buf.add_workspace_folder, "Add folder as workspace." },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder." },
        l = { function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders."
        }
      }
    }, {
      mode = 'n',
      buffer = ev.buf,
      prefix = "<leader>"
    })
  end,
})
