return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function ()
		vim.keymap.set(
			"n",
			"<leader>dt",
			function() require("trouble").open() end,
			{ desc = "open trouble" }
		)
		vim.keymap.set(
			"n",
			"<leader>dw",
			function() require("trouble").open("workspace_diagnostics") end,
			{ desc = "open workspace diagnostics" }
		)
		vim.keymap.set(
			"n",
			"<leader>dd",
			function() require("trouble").open("document_diagnostics") end,
			{ desc = "open doc diagnostics" }
		)
		vim.keymap.set(
			"n",
			"<leader>dq",
			function() require("trouble").open("quickfix") end,
			{ desc = "open quickfix" }
		)
		vim.keymap.set(
			"n",
			"<leader>dl",
			function() require("trouble").open("loclist") end,
			{ desc = "open loclist" }
		)
		vim.keymap.set(
			"n",
			"<leader>dr",
			function() require("trouble").open("lsp_references") end,
			{ desc = "open lsp references" }
		)
		require("trouble").setup {
			signs = {
				error = "ERROR",
				warning = "WARN",
				hint = "HINT",
				information = "FYI",
				other = "OTHER",
			},
			use_diagnostics_sings = false,
		}
	end
}
