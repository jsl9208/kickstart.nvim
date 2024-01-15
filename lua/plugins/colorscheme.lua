return {
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        integrations = {
          fidget = true,
          mason = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          treesitter_context = true,
          lsp_trouble = true,
          which_key = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- bufferline integrations for catppuccin
  {
    'akinsho/bufferline.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
    end,
  },
}
