local M = {}

M.is_nixos = function()
  local is_nixos = false
  local uname = vim.loop.os_uname().sysname

  if uname == "Linux" then
    local f = io.popen("cat /etc/os-release")
    if f ~= nil then
      for line in f:lines() do
        if line:find("ID=nixos") then
          is_nixos = true
          break
        end
      end
      f:close()
    end
  end

  return is_nixos
end

return M
