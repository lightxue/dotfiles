local M = {}

local box_chars = {
    top_bottom    = '─',
    sides         = '│',
    top_left      = '╭',
    top_right     = '╮',
    bottom_right  = '╯',
    bottom_left   = '╰',
}

local cow = {
[[       o]],
[[        o   ^__^]],
[[         o  (oo)\_______]],
[[            (__)\       )\/\]],
[[                ||----w |]],
[[                ||     ||]],
}

local function draw_box(lines)
    local strdisplaywidth = require("plenary.strings").strdisplaywidth

    local max_width = 0
    for _, l in ipairs(lines) do
        max_width = math.max(max_width, strdisplaywidth(l))
    end

    local top_bottom_border = string.rep(box_chars.top_bottom, max_width + 2)
    local top = box_chars.top_left .. top_bottom_border .. box_chars.top_right
    local bottom = box_chars.bottom_left .. top_bottom_border .. box_chars.bottom_right

    local box = { top }
    for _, l in ipairs(lines) do
        local offset = max_width - strdisplaywidth(l)
        table.insert(box,
                     string.format('%s %s%s %s',
                                   box_chars.sides,
                                   l,
                                   string.rep(' ', offset),
                                   box_chars.sides))
    end
    table.insert(box, bottom)
    return box
end

local function cowsay(lines)
    local List = require 'plenary.collections.py_list'
    local box = List(draw_box(lines))
    return box:concat(cow)
end

local function alpha_reset()
    -- local startify = require'alpha.themes.startify'
    local dashboard = require'alpha.themes.dashboard'
    dashboard.section.header.val = cowsay(require'alpha.fortune'())
    require'alpha'.setup(dashboard.opts)
end

function M.setup()
    vim.api.nvim_create_user_command('Startify', function()
        alpha_reset()
        require'alpha'.start(false)
    end, {
        bang = true,
        desc = 'require"alpha".start(false)',
    })
    alpha_reset()
end

return M
