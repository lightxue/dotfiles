local M = {}

function M.setup(_)
    local rtp = vim.opt.runtimepath:get()[1]
    require("dap-vscode-js").setup({
        debugger_path = rtp .. "/bundle/vscode-js-debug",
        adapters = { 'pwa-node'},
    })

    for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            -- {
            --     type = "pwa-node",
            --     request = "attach",
            --     name = "Attach",
            --     processId = require'dap.utils'.pick_process,
            --     cwd = "${workspaceFolder}",
            -- }
        }
    end
end

return M
