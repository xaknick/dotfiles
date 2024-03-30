return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- Function to check for ESLint configuration
    local function has_eslint_config()
      -- Define common ESLint config file names
      local eslint_config_files = {".eslintrc.js", ".eslintrc.json", ".eslintrc", ".eslintrc.yml", ".eslintrc.yaml"}
      for _, config_file in ipairs(eslint_config_files) do
        -- Use vim.fn.glob to check for file existence (supports pattern matching)
        if vim.fn.glob(config_file) ~= "" then
          return true
        end
      end
      return false
    end

    -- Default null-ls sources
    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.completion.spell,
      null_ls.builtins.formatting.prettierd,
    }

    -- Conditionally add eslint_d to null-ls sources
    if has_eslint_config() then
      table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
    end

    -- Setup null-ls with the configured sources
    null_ls.setup({
      sources = sources,
    })
  end
}

