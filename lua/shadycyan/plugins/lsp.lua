return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },

		-- Language support, mainly for indentation
		{ "dart-lang/dart-vim-plugin" },

		{ "j-hui/fidget.nvim", tag = "legacy" },
	},
	config = function()
		local lsp_zero = require("lsp-zero")
		local lsp_config = require("lspconfig")


		lsp_zero.preset("minimal")

		lsp_zero.ensure_installed({
			"lua_ls",
			"yamlls",
			"jsonls",
		})

		-- Fix Undefined global 'vim'
		lsp_zero.configure("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr }

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>gr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set({ "n", "i" }, "<C-b>", function()
				vim.lsp.buf.inlay_hint(0, nil)
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
			vim.keymap.set("n", "<leader>ds", function()
				vim.diagnostic.setqflist()
			end, opts)
		end

		lsp_zero.on_attach(on_attach)

		vim.diagnostic.config({
			virtual_text = true,
			signs = false,
		})

		lsp_config["dartls"].setup({
			on_attach = on_attach,
			settings = {
				dart = {
					analysisExcludedFolders = {
						vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
						vim.fn.expand("$HOME/.pub-cache"),
						vim.fn.expand("/opt/homebrew/"),
						vim.fn.expand("$HOME/tools/flutter/"),
					},
					updateImportsOnRename = true,
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		})

		lsp_config["lua_ls"].setup({
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

		lsp_zero.setup()

		local cmp = require("cmp")

		local cmp_mappings = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-y>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		})

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "buffer", keyword_length = 5 },
			},
			mapping = cmp_mappings,
		})

		require("fidget").setup({})
	end
}
