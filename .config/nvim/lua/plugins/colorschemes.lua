return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup({
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
            })
        end,
    },
    {
        "Skardyy/makurai-nvim",
        lazy = false,
        config = function()
            require("makurai").setup({
                transparent = false, -- removes the bg color
            })
        end,
    },
    {
        "rktjmp/lush.nvim",
    },
    { "catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000 },
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "Everblush/everblush.nvim",
        lazy = false,
        priority = 1000,
    },
}
-- vim: ts=2 sts=2 sw=2 et
