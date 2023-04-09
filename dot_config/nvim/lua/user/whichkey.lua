local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["<F1>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step over," },
	["<F2>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
	["<F3>"] = { "<cmd>lua require('dap').step_out()<CR>,", "Step Out" },

	["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
	["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
	["<F8>"] = { "<cmd>lua require('dap').toggle<CR>", "Toggle" },

	["A"] = { "<cmd>Alpha<cr>", "Alpha" },
	["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["v"] = { "<cmd>vsplit<CR>", "Vsplit" },
	["h"] = { "<cmd>split<CR>", "Split" },
	["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment Lines" },
	["T"] = { "<cmd>:ToggleBool<CR>", "Toggle Boolean" },
	f = {
		name = "Find",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		s = { "<cmd>Telescope grep_string<cr>", "Find String" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		H = { "<cmd>Telescope highlights<cr>", "Highlights" },
		-- i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
		n = { "<cmd>Telescope notify<cr>", "Notification History" },
		T = { "<cmd>Telescope treesitter<cr>", "Treesitter" },

		d = {
			name = "Debug",
			c = { "<cmd>lua require 'telescope'.extensions.dap.commands{}<CR>", "DAP Commands" },
			C = { "<cmd>lua require 'telescope'.extensions.dap.configurations{}<CR>", "DAP Configuration" },
			b = { "<cmd>lua require 'telescope'.extensions.dap.breakpoints{}<CR>", "DAP Breakpoints" },
			v = { "<cmd>lua require 'telescope'.extensions.dap.variables{}<CR>", "DAP Variables" },
			f = { "<cmd>lua require 'telescope'.extensions.dap.frames{}<CR>", "DAP Frames" },
		},
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = { "<cmd>G commit<cr>", "Create commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "LazyGit" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>Telescope lsp_code_actions<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0 <cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		c = { '<cmd>lua require("lua_lines").toggle<cr>', "Toggle virtual lines" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		v = { "<cmd>lua vim.diagnostic.config({virtual_text=true})<cr>", "Enable virtual text" },
		V = { "<cmd>lua vim.diagnostic.config({virtual_text=false})<cr>", "Disable virtual text" },
	},
	s = {
		name = "sops",
		v = { ':TermExec cmd="exec sops %"<CR>', "Open in SOPS" },
		e = { ":!sops -e -i %<CR>", "Encrypt with SOPS" },
		d = { ":!sops -d -i %<CR>", "Decrypt with SOPS" },
	},
	t = {
		name = "ToggleTerm",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	d = {
		name = "Debug",
		s = {
			name = "Step",
			c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
			v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
			i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
			o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
		},
		h = {
			name = "Hover",
			h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
			v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
		},
		u = {
			name = "UI",
			h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
			f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
		},
		r = {
			name = "Repl",
			o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
			l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
		},
		b = {
			name = "Breakpoints",
			c = {
				"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				"Breakpoint Condition",
			},
			m = {
				"<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
				"Log Point Message",
			},
			t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
		},
		c = { "<cmd>lua require('dap').scopes()<CR>", "Scopes" },
		i = { "<cmd>lua require('dap').toggle()<CR>", "Toggle" },
	},
	n = {
		name = "Neotest",
		a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
		f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
		F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
		l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
		L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
		n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
		N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
		o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
		S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
		s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
	},
}
vim.keymap.set("", "<Leader>lt", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

which_key.setup(setup)
which_key.register(mappings, opts)
