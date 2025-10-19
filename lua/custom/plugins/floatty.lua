return {
  'ingur/floatty.nvim',
  event = 'VeryLazy',
  config = function()
    local term = require('floatty').setup {}

    vim.keymap.set('n', '<C-t>', function()
      term.toggle()
    end)
    vim.keymap.set('t', '<C-t>', function()
      term.toggle()
    end)
  end,
}
