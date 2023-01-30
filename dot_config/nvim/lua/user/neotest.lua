local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
	return
end

neotest.setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			args = { "--doctest-modules" },
			runner = "pytest",
			is_test_file = function(file_path)
				if vim.endswith(file_path, ".py") then
					return true
				end
			end,
		}),
		require("neotest-vim-test")({
			ignore_file_types = { "python", "vim", "lua" },
		}),
	},
})
