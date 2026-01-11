-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    notify = true,
                }
            })
        end
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-macchiato",
        },
    },

    -- change some telescope options and a keymap to browse plugin files
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            -- add a keymap to browse plugin files
            -- stylua: ignore
            {
                "<leader>fp",
                function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
                desc = "Find Plugin File",
            },
        },
        -- change some options
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
    },

    -- add pyright to lspconfig
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                ruff = {
                    init_options = {
                        settings = {
                            logLevel = "error",
                        },
                    },
                },
                -- pyright will be automatically installed with mason and loaded with lspconfig
                pyright = {},
                -- stylua = { enabled = true },
            },
        },
    },
    {
        'nvim-java/nvim-java',
        config = function()
            require('java').setup()
            vim.lsp.enable('jdtls')
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "c",
                "cpp",
                "c_sharp",
                "python",
                "terraform",
                "query",
                "java",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
            },
        },
    },
    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
        "mason-org/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry"
            },
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
            },
        },
    },
    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        -- opts = {}
    },
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
                    "fallback",
                },
            },
        },
    },
    {
        "folke/trouble.nvim",
        enabled = true,
        opts = {
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        lazy = true,
        cmd = "ConformInfo",
        opts = function()
            ---@type conform.setupOpts
            local opts = {
                default_format_opts = {
                    timeout_ms = 3000,
                    async = false,           -- not recommended to change
                    quiet = false,           -- not recommended to change
                    lsp_format = "fallback", -- not recommended to change
                },
                formatters_by_ft = {
                    lua = { "lua_ls" },
                    fish = { "fish_indent" },
                    sh = { "shfmt" },
                    cs = { "csharpier" },
                },
                -- The options you set here will be merged with the builtin formatters.
                -- You can also define any custom formatters here.
                ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
                formatters = {
                    injected = { options = { ignore_errors = true } },
                    csharpier = function()
                        local useDotnet = not vim.fn.executable("csharpier")
                        local command = useDotnet and "dotnet csharpier" or "csharpier"
                        local version_out = vim.fn.system(command .. " --version")
                        -- vim.notify(version_out)
                        local version_result = version_out[#version_out]
                        local major_version = tonumber((version_out or ""):match("^(%d+)")) or 0
                        local is_new = major_version >= 1
                        -- vim.notify(tostring(is_new))
                        local args = is_new and { "format", "$FILENAME" } or { "--write-stdout" }
                        return {
                            command = command,
                            args = args,
                            stdin = not is_new,
                            require_cwd = false,
                        }
                    end,

                    -- # Example of using dprint only when a dprint.json file is present
                    -- dprint = {
                    --   condition = function(ctx)
                    --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                    --   end,
                    -- },
                    --
                    -- # Example of using shfmt with extra args
                    -- shfmt = {
                    --   prepend_args = { "-i", "2", "-ci" },
                    -- },
                },
            }
            return opts
        end
    },
    {
        "folke/snacks.nvim",
        opts = {
            explorer = { enabled = false },
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        enabled = false,
    }
}
