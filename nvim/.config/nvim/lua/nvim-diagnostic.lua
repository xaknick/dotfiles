function ToggleVirtualText()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
  print("virtual_text: " .. tostring(not current))
end

function ToggleVirtualLines()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = not current })
  print("virtual_lines: " .. tostring(not current))
end

vim.api.nvim_create_user_command("ToggleVirtualText", ToggleVirtualText, {})
vim.api.nvim_create_user_command("ToggleVirtualLines", ToggleVirtualLines, {})

vim.keymap.set("n", "<leader>tv", ToggleVirtualText, { desc = "Toggle virtual_text" })
vim.keymap.set("n", "<leader>tl", ToggleVirtualLines, { desc = "Toggle virtual_lines" })
