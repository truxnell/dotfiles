vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

--#region git
local gitgroup = vim.api.nvim_create_augroup("_git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "gitcommit",
	callback = function()
		vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
		vim.api.nvim_set_option_value("spell", true, { scope = "local" })
	end,
	group = gitgroup,
})
--#endregion git

--#region chezmoi
local chezmoigroup = vim.api.nvim_create_augroup("_chezmoi", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "~/.local/share/chezmoi/chezmoi/*",
	callback = function()
		-- TODO: Chezmoi apply
	end,
	group = chezmoigroup,
})
--#endregion chezmoi

--#region svn
local svngroup = vim.api.nvim_create_augroup("_svn", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "svn",
	callback = function()
		vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
		vim.api.nvim_set_option_value("spell", true, { scope = "local" })
	end,
	group = svngroup,
})
--#endregion svn

--#region TextYankin
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})
--#endregion TextYankin

--#region Yaml
local yamlgroup = vim.api.nvim_create_augroup("_yaml", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "yaml",
	group = yamlgroup,
	callback = function()
		vim.api.nvim_set_option_value("ts", 2, { scope = "local" })
		vim.api.nvim_set_option_value("sts", 2, { scope = "local" })
		vim.api.nvim_set_option_value("sw", 2, { scope = "local" })
		vim.api.nvim_set_option_value("expandtab", true, { scope = "local" })
	end,
})
--#endregion Yaml

--#region markdown
local markdowngroup = vim.api.nvim_create_augroup("_markdown", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "markdown",
	callback = function()
		vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
		vim.api.nvim_set_option_value("spell", true, { scope = "local" })
		-- changes ... to the elispis character to make proselint happy, but only in markdown files
		vim.cmd("iab ... …")
	end,
	group = markdowngroup,
})
--#endregion svn
