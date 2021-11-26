-- Plugin Configs
local capabilities = vim.lsp.protocol.make_client_capabilities()
local nvim_lsp = require('lspconfig')
vim.g.coq_settings = { auto_start = 'shut-up' }
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

require'indent_blankline'.setup {
  char = "|", 
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
    enable = true
  }
}

require'gitsigns'.setup {
  numhl = true,
  current_line_blame = true,
  current_line_blame_opts = { delay = 0 }
}

require'telescope'.setup {
  defaults = {
    prompt_prefix=🔍,
    layout_config = {
      horizontal = { width = 0.9 }
    }
  }
}

require'lualine'.setup {
  options = { theme = 'nord' }
}

require('bufferline').setup {
  options = {
    offsets = {
      {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center"
      }
    }
  }
}

require('lspkind').init{ with_text=false }
require("lsp-colors").setup{}
