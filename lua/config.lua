-- Plugin Configs
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local nvim_lsp = require('lspconfig')
nvim_lsp.rust_analyzer.setup{capabilities = capabilities}
nvim_lsp.diagnosticls.setup{capabilities = capabilities}
nvim_lsp.solargraph.setup{capabilities = capabilities}
nvim_lsp.tsserver.setup{capabilities = capabilities}
nvim_lsp.sumneko_lua.setup{capabilities = capabilities}

-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  },
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●", signs = true },
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
  buftype_exclude = {"terminal", "alpha"},
  filetype_exclude = {"alpha"}
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
    icons_enabled = true,
    globalstatus = true
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
require'Comment'.setup {}
require'alpha'.setup(require'alpha.themes.dashboard'.config)
require'nvim-lsp-installer'.setup {}
require'luasnip'.filetype_extend("ruby", {"rails"})
