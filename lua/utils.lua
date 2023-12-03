local fn = vim.fn
local M = {}

function M.executable(name)
  if fn.executable(name) > 0 then
    return true
  end
  return false
end

M.has = function(feat)
  if fn.has(feat) == 1 then
    return true
  end

  return false
end

return M
