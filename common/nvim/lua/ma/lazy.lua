-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("ma.plugins", {
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  change_detection = {
    notify = false,
  },
})

-- Set colorscheme according to what was defined in `options.lua`
vim.cmd.colorscheme(vim.g.colorscheme)

-- Set transparency according to what was defined in `options.lua`
if vim.g.transparent_enabled then
  vim.cmd('TransparentEnable')
else
  vim.cmd('TransparentDisable')
end

if vim.g.background_dark_mode then
    vim.cmd('set background=dark')
else
    vim.cmd('set background=light')
end

