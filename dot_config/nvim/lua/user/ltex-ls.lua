local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
local words = {}

for word in io.open(path, "r"):lines() do
	table.insert(words, word)
end

nvim_lsp.ltex.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		ltex = {
			disabledRules = { ["en-GB"] = { "PROFANITY" } },
			dictionary = { ["en-GB"] = words },
		},
	},
})
