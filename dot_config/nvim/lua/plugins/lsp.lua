return {

  -- mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "prettier",
        -- "deno",
        "shfmt",
        "black",
        "isort",
        "flake8",
        "ltex-ls",
      })
    end,
  },
  { "barreiroleo/ltex-extra.nvim" },
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- disable lsp watcher. Too slow on linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end
    end,
    opts = {
      ---@type lspconfig.options
      servers = {
        ltex = {
          on_attach = function(client, bufnr)
            print("Loading ltex from ltex_extra")
            require("ltex_extra").setup({
              init_check = true,
              load_langs = { "en-AU" }, -- table <string> : language for witch dictionaries will be loaded
              log_level = "error", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
              path = vim.fn.expand("~") .. "/.config/nvim/spell/",
            })
          end,
          settings = {
            ltex = {
              completionEnabled = true,
              statusBarItem = true,
              languageToolHttpServerUri = "https://language-tools.trux.dev/",
              checkFrequency = "save",
              language = "en-AU",
              additionalRules = {
                enablePickyRules = true,
              },
            },
          },
        },
        ansiblels = {},
        bashls = {},
        dockerls = {},
        html = {},
        gopls = {},
        marksman = {},
        pyright = {
          enabled = false,
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        vimls = {},
      },
      setup = {},
    },
  },

  -- null-ls
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    vim.list_extend(opts.sources, {
      nls.builtins.formatting.dprint,
      nls.builtins.formatting.prettier.with({ filetypes = { "markdown" } }),
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.deno_lint,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.black,
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.luacheck.with({
        condition = function(utils)
          return utils.root_has_file({ ".luacheckrc" })
        end,
      }),
    })
  end,

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = false },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },

  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          ---@type lsp.Client
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf, false)
        end,
      })
    end,
  },

  -- {
  -- "barreiroleo/ltex_extra.nvim",
  -- dev = false,
  -- ft = { "markdown", "tex" },
  -- opts = {
  --   init_check = true,
  --   load_langs = { "en-AU" }, -- table <string> : language for witch dictionaries will be loaded
  --   log_level = "trace", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
  --   path = vim.fn.expand("~") .. "/.config/nvim/spell/",
  --   server_opts = {
  --     on_attach = function(client, bufnr)
  --       print("Loading ltex from ltex_extra")
  --       require("ltex_extra").on_attach(client, bufnr)
  --     end,
  --     filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
  --     settings = {
  --       ltex = {
  --         completionEnabled = true,
  --         statusBarItem = true,
  --         languageToolHttpServerUri = "https://language-tools.trux.dev/",
  --         checkFrequency = "save",
  --         language = "en-AU",
  --         additionalRules = {
  --           enablePickyRules = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  -- },
}
