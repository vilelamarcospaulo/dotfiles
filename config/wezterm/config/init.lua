local wezterm = require('wezterm')

local function deep_merge(t1, t2)
  for k, v in pairs(t2) do
    if k == "keys" and type(v) == "table" and type(t1[k]) == "table" then
      -- Concatenate arrays for 'keys'
      for _, item in ipairs(v) do
        table.insert(t1[k], item)
      end
    elseif type(v) == "table" and type(t1[k]) == "table" then
      deep_merge(t1[k], v)
    else
      if t1[k] ~= nil and type(t1[k]) ~= "table" then
        wezterm.log_warn(
          'Duplicate config option detected: ',
          { old = t1[k], new = v }
        )
      end
      t1[k] = v
    end
  end
end

---@class Config
---@field options table
local Config = {}
Config.__index = Config

---Initialize Config
---@return Config
function Config:init()
  local config = setmetatable({ options = {} }, self)
  return config
end

---Append to `Config.options`
---@param new_options table new options to append
---@return Config
function Config:append(new_options)
  deep_merge(self.options, new_options)
  return self
end

return Config
