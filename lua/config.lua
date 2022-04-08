-- Plugin Configs
local capabilities = vim.lsp.protocol.make_client_capabilities()
local nvim_lsp = require('lspconfig')
vim.g.coq_settings = { auto_start = 'shut-up', clients = { tree_sitter = { slow_threshold = 1 }} }
local coq = require('coq')

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

nvim_lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({capabilities = capabilities}))
nvim_lsp.diagnosticls.setup(coq.lsp_ensure_capabilities({capabilities = capabilities}))
nvim_lsp.solargraph.setup(coq.lsp_ensure_capabilities({capabilities = capabilities}))
nvim_lsp.tsserver.setup(coq.lsp_ensure_capabilities({capabilities = capabilities}))

-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.wo.colorcolumn = "99999"
vim.g.indent_blankline_context_patterns = {
  "class",
  "return",
  "function",
  "method",
  "^if",
  "^while",
  "jsx_element",
  "^for",
  "^object",
  "^table",
  "block",
  "arguments",
  "if_statement",
  "else_clause",
  "jsx_element",
  "jsx_self_closing_element",
  "try_statement",
  "catch_clause",
  "import_statement",
  "operation_type",
}

require'indent_blankline'.setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  buftype_exclude = {"terminal"} 
}

require'nvim-tree'.setup {
  disable_netrw = false,
  diagnostics = {
    enable = true
  }
}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true
  },
  indent = { enable = true },
  context_commentstring = {
    enable = true,
    config = { c = "// %s", lua = "-- %s", vim = '" %s' },
  },
}

require'gitsigns'.setup {
  numhl = true,
  current_line_blame = true,
  current_line_blame_opts = { delay = 0 },
  signs = {
    add = { 
      hl = "GitSignsAdd", 
      text = "▍", 
      numhl = "GitSignsAddNr", 
      linehl = "GitSignsAddLn" 
    },
    change = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "▸",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "▾",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
}

require'telescope'.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    vimgrep_arguments = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    layout_config = {
      prompt_position = 'top',
      horizontal = {
        mirror = false,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
      width = 0.95,
      preview_cutoff = 120,
      preview_width = 80,
    },
    scroll_strategy = "cycle",
    winblend = 4,
    color_devicons = true,
  }
}

local function lsp_progress(self, is_active)
  if not is_active then
    return ""
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

require'lualine'.setup {
  options = { 
    theme = 'tokyonight',
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    icons_enabled = true
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { { "diagnostics", sources = { "nvim_diagnostic" } }, "filename" },
    lualine_x = { "filetype", lsp_progress },
    lualine_y = { "buffers", "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" }
}

require'bufferline'.setup {
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    },
    view = "multiwindow",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. sym .. n
      end
      return s
    end
  }
}

require'lsp-colors'.setup {}
require'which-key'.setup {}
require'nvim-treesitter.configs'.setup {
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
        }
    },
}
