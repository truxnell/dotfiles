-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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
  pattern = "**/.local/share/chezmoi/dot_config/nvim/**",
  callback = function()
    local job = require("plenary.job")
    job
      :new({
        -- TODO: a better notification
        command = "chezmoi",
        args = { "apply", "--source-path", vim.api.nvim_buf_get_name(0) },
        on_start = function()
          vim.notify("Writing for" .. vim.api.nvim_buf_get_name(0))
        end,
        on_exit = function()
          vim.notify("Chezmoi Complete")
        end,
      })
      :start()
  end,
  group = chezmoigroup,
})
--#endregion chezmoi
-- TODO: This should be better handled by ftdetect folders
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
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("better_backup", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- require("lazyvim.util").on_attach(function(_, buffer)
--   -- create the autocmd to show diagnostics
--   vim.api.nvim_create_autocmd("CursorHold", {
--     group = vim.api.nvim_create_augroup("_auto_diag", { clear = true }),
--     buffer = buffer,
--     callback = function()
--       local opts = {
--         focusable = false,
--         close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--         border = "rounded",
--         source = "always",
--         prefix = " ",
--         scope = "cursor",
--       }
--       vim.diagnostic.open_float(nil, opts)
--     end,
--   })
-- end)
