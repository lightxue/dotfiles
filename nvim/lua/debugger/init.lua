local M = {}

local function configure()
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#993939', bg='#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg=0, fg='#61afef', bg='#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#98c379', bg='#31353f' })

    vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointCondition', { text='♦️', texthl='', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointRejected', { text='⛔️', texthl='', linehl='', numhl= '' })
    vim.fn.sign_define('DapLogPoint', { text='ℹ️', texthl='', linehl='', numhl= '' })
    vim.fn.sign_define('DapStopped', { text='👉', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
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
    configure_exts() -- Extensions
    configure() -- Configuration
    configure_debuggers() -- Debugger
    require("debugger.keymaps").setup() -- Keymaps
end

-- configure_debuggers()

return M
