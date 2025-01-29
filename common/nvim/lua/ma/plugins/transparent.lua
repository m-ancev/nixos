return {
  enabled = false,
  "xiyaowong/transparent.nvim",
  config = function()
    require('transparent').setup({
      groups = {
        -- Existing default groups
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
        'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
        'LineNr', 'NonText', 'SignColumn', 'CursorLine', 'CursorLineNr',
        'StatusLine', 'StatusLineNC', 'EndOfBuffer', 'FoldColumn', 'Folded', 'UfoFoldedFg', 'UfoFoldedBg'
      },
      extra_groups = {
        -- Add plugin-specific and border-related groups
        'NormalFloat', 'TelescopeNormal', 'TelescopeBorder',
        'BufferLineFill', 'BufferLineBackground', 'BufferLineTab',
        'FloatBorder', 'WinSeparator', 'VertSplit', 'LspFloatBorder',
      },
      exclude_groups = {},   -- Exclude groups from clearing
    })
    -- For plugins with dynamic highlight groups, use clear_prefix:
    require('transparent').clear_prefix('BufferLine')
    require('transparent').clear_prefix('Telescope')
    require('transparent').clear_prefix('Lualine')
    require('transparent').clear_prefix('Gitsigns')
    require('transparent').clear_prefix('Todo')

    -- Enable transparency
    vim.cmd('TransparentEnable')
  end,
}
