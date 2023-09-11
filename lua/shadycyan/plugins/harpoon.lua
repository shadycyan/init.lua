return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local keymap = vim.keymap

		keymap.set("n", "<leader>ha", mark.add_file, { desc = "add file to harpoon" })
		keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "toggle harpoon menu"})

		keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "harpoon to first file" })
		keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = "harpoon to second file" })
		keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "harpoon to third file" })
		keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = "harpoon to fourth file" })
  end,
}
