return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	dependencies = {
		{
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			-- Autocompletion
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/nvim-cmp' },
			{ 'L3MON4D3/LuaSnip' },

			{ 'akinsho/flutter-tools.nvim' },

			{ 'nvim-lua/plenary.nvim' },
			{ 'stevearc/dressing.nvim' },

			{ "dart-lang/dart-vim-plugin" },
		},
	},
	config = function()
		local lsp_zero = require('lsp-zero')

		-- -- (Optional) configure lua language server
		-- local lua_opts = lsp_zero.nvim_lua_ls()
		-- require('lspconfig').lua_ls.setup(lua_opts)

		-- Replace the language servers listed here
		-- with the ones you have installed
		lsp_zero.setup_servers({
			'dartls',
		})

		require 'lspconfig'.dartls.setup {
			cmd = { "dart", 'language-server', '--protocol=lsp' },
			init_options = {
				closingLabels = true,
				flutterOutline = true,
				onlyAnalyzeProjectsWithOpenFiles = true,
				outline = true,
				suggestFromUnimportedLibraries = true
			}
		}

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

		require('mason').setup({})

		require('mason-lspconfig').setup({
			ensure_installed = {
				"yamlls",
				"jsonls",
			},
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					require('lspconfig').lua_ls.setup(lua_opts)
				end,
			}
		})

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
		end)

		lsp_zero.format_on_save({
			format_opts = {
				async = true,
				timeout_ms = 10000,
			},
			servers = {
				['dartls'] = { 'dart' },
				['rust_analyzer'] = { 'rust' },
				['tsserver'] = { 'javascript', 'typescript' },
			}
		})


		lsp_zero.set_sign_icons({
			error = '❌',
			warn = '⚠️',
			hint = '⛳️',
			info = 'ℹ️'
		})

		local cmp = require('cmp')
		local cmp_action = require('lsp-zero').cmp_action()

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				-- `Enter` key to confirm completion
				['<CR>'] = cmp.mapping.confirm({ select = false }),

				-- Ctrl+Space to trigger completion menu
				['<C-Space>'] = cmp.mapping.complete(),

				-- Navigate between snippet placeholder
				['<C-f>'] = cmp_action.luasnip_jump_forward(),
				['<C-b>'] = cmp_action.luasnip_jump_backward(),

				-- Scroll up and down in the completion documentation
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
			})
		})


		local auto_group = vim.api.nvim_create_augroup("LspAuGroup", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				-- highlight references

				-- if client.server_capabilities.documentHighlightProvider then
				-- 	vim.api.nvim_create_autocmd("CursorHold", {
				-- 		callback = function() vim.lsp.buf.document_highlight() end,
				-- 		group = auto_group,
				-- 	})
				-- 	vim.api.nvim_create_autocmd("CursorMoved", {
				-- 		callback = function() vim.lsp.buf.clear_references() end,
				-- 		group = auto_group,
				-- 	})
				-- end

				-- auto-format

				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function() vim.lsp.buf.format() end,
						group = auto_group,
					})
				end
			end,
		})
	end,
}
