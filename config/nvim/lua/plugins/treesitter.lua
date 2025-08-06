return {
  { "nvim-treesitter/nvim-treesitter",  branch = 'master', lazy = false, build = ":TSUpdate" },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  { 'github/copilot.vim' },
  { 'nvim-tree/nvim-tree.lua',        opts = {}, dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'linrongbin16/lsp-progress.nvim', opts = {} },
}
