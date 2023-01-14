-- TODO: Add comment keymap.

local utils = require('user.utils')
local wk = utils.load_plug('which-key')
if wk == nil then
  return
end

local reg = wk.register


-- Reference: https://github.com/LunarVim/LunarVim/lua/lvim/core/bufferline.lua
local function try_close_buffer(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

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
  ["<M-j>"] = { "<cmd>move .+1<cr>==", "Move current line +1" }
}

reg({
  ["<M-k>"] = { ":move '<lt>-2<cr>gv-gv", "Move current line -2" },
  ["<M-j>"] = { ":move '>+1<cr>gv-gv", "Move current line +1" }
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
    O = { "<cmd>Telescope coc workspace_symbols<cr>", "Workspace Symbols" },
    o = { "<cmd>Telescope coc document_symbols<cr>", "Document Symbols" },
    r = { "<cmd>Telescope coc references_used<cr>", "Look up References of symbol" },
    R = { "<cmd>Telescope coc references<cr>", "Look up Calling of symbol" },
    D = { "<cmd>Telescope coc workspace_diagnostics<cr>", "Telescope Diagnostics" },
    d = { "<cmd>Telescope coc diagnostics<cr>", "Trouble Workspace Diagnostics" },
    b = { "<cmd>Telescope buffers<cr>", "Switch between buffers" },
    p = { "<cmd>Telescope find_files<cr>", "Files" },
    P = { "<cmd>Telescope commands<cr>", "Commands" },
    t = { "<cmd>Telescope live_grep use_regex=true<cr>", "Find string in ws" },
  },
  l = {
    name = "Lsp & Coc",
    a = { 
      name = "Code Action",
      c = { "<Plug>(coc-codeaction-cursor)", "Action for cursor" },
      s = { "<Plug>(coc-codeaction-source)", "Action for source" },
      b = { "<Plug>(coc-codeaction-buffer)", "Action for buffer" },
      a = { "<Plug>(coc-codelense-action)", "CodeLense action" },
      q = { "<Plug>(coc-fix-current)", "Quickfix Current" },
    },
    c = { "<Plug>(coc-codelens-action)", "CodeLens Action"},
    q = { "<Plug>(coc-fix-current)", "Quickfix Current" },
    o = { "<cmd>CocOutline<cr>", "Open coc-outline"},
    O = { "<cmd>Vista!<cr>", "Close Vista."},
    k = { "<Plug>(coc-diagnostic-prev)", "Goto previous diagnostic" },
    j = { "<Plug>(coc-diagnostic-next)", "Goto next diagnostic" },
    f = { "<cmd>CocCommand editor.action.formatDocument<cr>", "Format current document" },
    t = { "<cmd>Telescope coc commands<cr>", "Telescope commands" },
    d = { "<cmd>Telescope coc diagnostic<cr>", "Document Diagnostics"},
    D = { "<cmd>Telescope coc workspace_diagnostic<cr>", "Document Diagnostics"},
    s = { "<cmd>Telescope coc document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope coc workspace_symbols<cr>", "Workspace Symbols" },
    l = {
      name = "CocList",
      d = { "<cmd>CocList diagnostics<cr>", "Diagnostics" },
      e = { "<cmd>CocList extensions<cr>", "Diagnostics" },
      o = { "<cmd>CocList outline<cr>", "Diagnostics" },
      s = { "<cmd>CocList -I symbols<cr>", "Diagnostics" },
      p = { "<cmd>CocListResume<cr>", "Resume" },
      j = { "<cmd>CocListNext<cr>", "Coc default next" },
      k = { "<cmd>CocListPrev<cr>", "Coc default prev" },

    },
    r = {
      name = "Refactor and rename",
      r = { "<Plug>(coc-rename)", "Rename symble under cursor" },
      n = { "<Plug>(coc-rename)", "Rename symble under cursor" },
      e = { "<Plug>(coc-codeaction-refactor)", "Refactor"}
    }
  }

}, { prefix = "<leader>" })

reg ({
  name = "Coc Goto...",
  d = { "<Plug>(coc-definition)", "Definition" },
  t = { "<Plug>(coc-type-definition)", "Type Definition"},
  i = { "<Plug>(coc-implementation)", "Implementation" },
  r = { "<Plug>(coc-references)", "References" },
}, { prefix = "g" })
