-- ~/.config/nvim/lua/plugins/todo_comments.lua

require("todo-comments").setup({
    signs = true, -- show icons in the signs column
    keywords = {
        FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    merge_keywords = true, -- when true, the signs for the above keywords will be merged
    -- highlighting of the line containing the TODO comment
    highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "wide" or "narrow" (or any other highlight group)
        after = "fg", -- "fg", "bg", "wide", "narrow" or empty
    },
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
        },
        -- regex that will be used to match keywords.
        pattern = [[\b(KEYWORDS):]],
    },
})
