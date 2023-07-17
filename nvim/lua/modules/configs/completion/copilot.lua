return function()
    -- 保护公司代码，不使用copilot
    local function protect_work_code()
        if require('copilot.client').is_disabled() then
            return
        end

        -- 工蜂代码禁用copilot
        local git_remote = vim.fn.system({ 'git', 'config', '--get', 'remote.origin.url' })
        if string.find(git_remote, '.*git.woa.*') then
            require('copilot.command').disable()
            vim.notify('copilot disabled for git.woa.com code', vim.log.levels.INFO, { title = 'copilot' })
            return
        end

        -- 工作目录禁用copilot
        local work_path = os.getenv('HOME') .. '/work'
        local buffers = vim.api.nvim_list_bufs()
        for _, buf in ipairs(buffers) do
            local path = vim.api.nvim_buf_get_name(buf)
            if string.sub(path, 1, string.len(work_path)) == work_path then
                require('copilot.command').disable()
                vim.notify('copilot disabled for work code', vim.log.levels.INFO({ title = 'copilot' }))
                return
            end
        end
    end

    vim.defer_fn(function()
        require('copilot').setup({
            cmp = {
                enabled = true,
                method = 'getCompletionsCycling',
            },
            panel = {
                -- if true, it can interfere with completions in copilot-cmp
                enabled = false,
            },
            suggestion = {
                -- if true, it can interfere with completions in copilot-cmp
                enabled = false,
            },
            filetypes = {
                ['dap-repl'] = false,
                ['big_file_disabled_ft'] = false,
                ['markdown'] = false,
                ['csv'] = false,
            },
        })

        protect_work_code()
        vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
            pattern = { '*' },
            callback = function()
                protect_work_code()
            end,
        })
    end, 100)
end
