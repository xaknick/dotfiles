return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function lsp_clients()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return "" end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return "LSP: " .. table.concat(names, ", ")
    end

    local function formatters()
      local conform_ok, conform = pcall(require, "conform")
      if not conform_ok then return "" end
      local formatters_list = conform.list_formatters_to_run(0)
      if #formatters_list == 0 then return "" end
      local names = {}
      for _, formatter in ipairs(formatters_list) do
        table.insert(names, formatter.name)
      end
      return "FMT: " .. table.concat(names, ", ")
    end

    require("lualine").setup({
      options = {
        theme = 'auto'
      },
      sections = {
        lualine_x = { formatters, lsp_clients, 'encoding', 'fileformat', 'filetype' },
      }
    })
  end
}

