return {
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                {
                    mapping = cmp.mapping.preset.insert({
                        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                        ["<C-n"] = cmp.mapping.select_next_item(cmp_select),
                        ["<C-p"] = cmp.mapping.select_prev_item(cmp_select),
                        ["<C-Space"] = cmp.mapping.complete(),
                    }),
                },
            })
        end,
    },
}
