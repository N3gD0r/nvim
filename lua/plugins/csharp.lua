return {
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
    -- config = function()
    --   vim.lsp.config("roslyn", {
    --     settings = {
    --       ["csharp|inlay_hints"] = {
    --         csharp_enable_inlay_hints_for_implicit_object_creation = true,
    --         chsarp_enable_inhay_hints_for_implicit_variable_types = true,
    --       },
    --       ["csharp|code_lens"] = {
    --         dotnet_enable_references_code_lens = true,
    --       },
    --       ["csharp|background_analysis"] = {
    --         dotnet_analyzer_diagnostics_scope = "fullSolution",
    --         dotnet_compiler_diagnostics_scope = "fullSolution",
    --       },
    --     },
    --   })
    -- end,
  },
}
