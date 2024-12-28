return {
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require('transparent').setup({
        groups = { -- Default groups
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
          'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
          'LineNr', 'NonText', 'SignColumn', 'CursorLine', 'CursorLineNr',
          'StatusLine', 'StatusLineNC', 'EndOfBuffer',
        },
        extra_groups = {            -- Plugin-specific highlight groups
          'NormalFloat',            -- General floating windows
          'NvimTreeNormal',         -- NvimTree
          'TelescopeNormal',        -- Telescope
          'TelescopeBorder',        -- Telescope borders
          'TelescopePromptNormal',  -- Telescope prompt
          'TelescopeResultsNormal', -- Telescope results
          'TelescopePreviewNormal', -- Telescope preview
          'BufferLineFill',         -- For bufferline.nvim
          'BufferLineBackground',   -- Bufferline backgrounds
          'BufferLineTab',          -- Tabs
          'BufferLineTabClose',     -- Closing tabs
          'BufferLineTabSelected',  -- Selected tabs
          'LualineNormal',          -- Lualine
          'LualineInsert',          -- Lualine insert mode
          'LualineVisual',          -- Lualine visual mode
          'GitsignsAdd',            -- Gitsigns for added lines
          'GitsignsChange',         -- Gitsigns for changed lines
          'GitsignsDelete',         -- Gitsigns for deleted lines
          'TodoComment',            -- Highlight for todo-comments.nvim
          'Folded',                 -- Folded lines
          'UfoFoldedBg',            -- nvim-ufo folded background
          'FoldColumn',             -- Add FoldColumn to clear its background
        },
        exclude_groups = {},        -- Groups to exclude from clearing
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
  },
}
