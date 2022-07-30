local M = {}

local function configure()
    -- local dap_breakpoint = {
    --     error = {
    --         text = "🟥",
    --         texthl = "LspDiagnosticsSignError",
    --         linehl = "",
    --         numhl = "",
    --     },
    --     rejected = {
    --         text = "",
    --         texthl = "LspDiagnosticsSignHint",
    --         linehl = "",
    --         numhl = "",
    --     },
    --     stopped = {
    --         text = "⭐️",
    --         texthl = "LspDiagnosticsSignInformation",
    --         linehl = "DiagnosticUnderlineInfo",
    --         numhl = "LspDiagnosticsSignInformation",
    --     },
    -- }
    --
    -- vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    -- vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    -- vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

    vim.highlight.create('DapBreakpoint', { ctermbg=0, guifg='#993939', guibg='#31353f' }, false)
    vim.highlight.create('DapLogPoint', { ctermbg=0, guifg='#61afef', guibg='#31353f' }, false)
    vim.highlight.create('DapStopped', { ctermbg=0, guifg='#98c379', guibg='#31353f' }, false)

    vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
end

local function configure_exts()
    require("nvim-dap-virtual-text").setup {
        commented = true,
    }

    local dap, dapui = require "dap", require "dapui"
    dapui.setup {} -- use default
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --     dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --     dapui.close()
    -- end
end

local function configure_debuggers()
    require("debugger.lua").setup()
    require("debugger.python").setup()
    require("debugger.go").setup()
    require("debugger.javascript").setup()
end

function M.setup()
    configure() -- Configuration
    configure_exts() -- Extensions
    configure_debuggers() -- Debugger
    require("debugger.keymaps").setup() -- Keymaps
end

-- configure_debuggers()

return M
