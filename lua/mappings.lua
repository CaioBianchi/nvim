-- Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<leader>ff', ':Telescope find_files<cr>', opts)
map('n', '<leader>fg', ':Telescope live_grep<cr>', opts)
map('n', '<leader>fb', ':Telescope buffers<cr>', opts)
map('n', '<leader>fh', ':Telescope help_tags<cr>', opts)
map('n', '<leader>fp', ':Telescope planets<cr>', opts)
map('n', '<leader>fd', ':Telescope file_browser<cr>', opts)
map('n', '<leader>fl', ':Telescope git_commits<cr>', opts)
map('n', '<C-\\>', ':NvimTreeToggle<cr>', opts)
map('n', '<leader>bp', ':BufferLinePickClose<cr>', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-l>', '<C-w>l', opts)

