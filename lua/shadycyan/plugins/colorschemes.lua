return {
  {
		"EdenEast/nightfox.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme carbonfox]])
			--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			-- Set the background of the number column to "none"
			--vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })

			-- Set the background of the column behind the number column to "none"
			--vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })

			-- Set the sign column highlight group to have no background
			--vim.cmd('highlight SignColumn ctermbg=NONE guibg=NONE')
		end,
  },
}
