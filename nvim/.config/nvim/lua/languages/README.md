# Language Configuration System

This directory contains language-specific configurations organized by programming language. Each language can have up to 3 files:

- `lsp.lua` - Language Server Protocol configuration
- `dap.lua` - Debug Adapter Protocol configuration  
- `tools.lua` - Formatters, linters, and other tools

## Quick Start

1. Create directory: `mkdir lua/languages/LANGUAGE_NAME`
2. Add language to registry: Edit `init.lua` and add `"LANGUAGE_NAME"` to the `languages` array
3. Create config files as needed (see templates below)

## Templates

### LSP Template (`lsp.lua`)

```lua
local M = {}

-- LSP servers to install via Mason
M.servers = { "server_name" }

function M.setup()
	-- Option 1: Use defaults (just return, no config needed)
	-- return
	
	-- Option 2: Custom configuration
	vim.lsp.config("server_name", {
		settings = {
			-- Server-specific settings
		},
		-- Custom handlers, capabilities, etc.
	})
	
	-- Option 3: Language-specific keymaps
	vim.keymap.set("n", "<leader>cx", function()
		-- Custom command
	end, { desc = "Custom action" })
end

return M
```

### DAP Template (`dap.lua`)

```lua
local M = {}

function M.setup()
	local dap = require("dap")
	
	-- Only configure debugging sessions
	-- Adapters are handled by mason-nvim-dap automatically
	dap.configurations.FILETYPE = {
		{
			type = "adapter_name",
			name = "Debug description",
			request = "launch",
			program = "${file}", -- or function for custom input
			-- Additional debug configuration
		},
	}
end

return M
```

### Tools Template (`tools.lua`)

```lua
local M = {}

-- Tools to install via Mason (linters, formatters, etc.)
M.tools = { "tool1", "tool2" }

-- Conform.nvim formatter configuration
M.formatters = {
	filetype1 = { "formatter1" },
	filetype2 = { "formatter1", "formatter2", stop_after_first = true },
}

return M
```

## Real Examples

### Simple Language (JSON)
```
json/
└── lsp.lua          # Just jsonls server, no custom config
```

### Complex Language (TypeScript)  
```
typescript/
├── lsp.lua          # vtsls + custom settings + keymaps
└── tools.lua        # prettierd, eslint_d
```

### Debug-Heavy Language (Go)
```
go/
├── lsp.lua          # gopls + gofumpt setting
└── dap.lua          # Go debugging configurations
```

## Registry System

The `init.lua` file automatically:
- Collects all LSP servers → `mason-lspconfig.ensure_installed`
- Collects all tools → `mason-tool-installer.ensure_installed`  
- Collects all formatters → `conform.formatters_by_ft`
- Loads all configurations safely with `pcall()`

## Best Practices

### When to Create Files

**Create `lsp.lua` when:**
- Need custom LSP settings
- Want language-specific keymaps
- Server requires special configuration

**Create `dap.lua` when:**
- Language supports debugging
- Need custom debug configurations
- Want multiple debug profiles

**Create `tools.lua` when:**
- Need formatters or linters
- Want tools auto-installed by Mason

### When NOT to Create Files

**Skip files when:**
- Using default LSP configuration (just add server to registry manually)
- Language doesn't support debugging (YAML, JSON, etc.)
- No special tools needed

### File Organization

- ✅ One language per directory
- ✅ Only create files that add value
- ✅ Use consistent naming: `lsp.lua`, `dap.lua`, `tools.lua`
- ✅ Always return a module table `M`

## Adding a New Language

Example: Adding Python support

```bash
# 1. Create directory
mkdir lua/languages/python

# 2. Add to registry
# Edit init.lua: add "python" to languages array

# 3. Create config files
cat > lua/languages/python/lsp.lua << 'EOF'
local M = {}

M.servers = { "pyright" }

function M.setup()
	vim.lsp.config("pyright", {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic"
				}
			}
		}
	})
end

return M
EOF

cat > lua/languages/python/tools.lua << 'EOF'  
local M = {}

M.tools = { "black", "ruff" }

M.formatters = {
	python = { "black" },
}

return M
EOF
```

That's it! The registry will automatically pick up the new language.