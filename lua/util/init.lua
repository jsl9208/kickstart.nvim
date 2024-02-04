local LazyUtil = require 'lazy.core.util'

---@class util
---@field ui util.ui
---@field lsp util.lsp
---@field root util.root
---@field terminal util.terminal
---@field lualine util.lualine
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require('util.' .. k)
    return t[k]
  end,
})

---@param plugin string
function M.has(plugin)
  return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---@param name string
function M.opts(name)
  local plugin = require('lazy.core.config').plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require 'lazy.core.plugin'
  return Plugin.values(plugin, 'opts', false)
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require 'lazy.core.config'
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
