local bind = require('keymap.bind')
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
    -- Plugin MarkdownPreview
    ['n|<leader>md'] = map_cr('MarkdownPreviewToggle'):with_noremap():with_silent():with_desc('tool: Preview markdown'),
    -- Indent
    ['n|<leader>ij'] = map_cr('%!jq --indent 4'):with_noremap():with_silent():with_desc('indent: Indent json'),
    ['v|<leader>ij'] = map_cr('!jq --indent 4'):with_noremap():with_silent():with_desc('indent: Indent json'),
    ['n|<leader>is'] = map_cr('%!sqlformat - -rs -k upper')
        :with_noremap()
        :with_silent()
        :with_desc('indent: Indent sql'),
    ['v|<leader>is'] = map_cr('!sqlformat - -rs -k upper'):with_noremap():with_silent():with_desc('indent: Indent sql'),
}

bind.nvim_load_mapping(plug_map)
