local M = {}

local path = vim.fn.stdpath 'data' .. '/myscriptvars.json'

-- Save values
function M.save(var1, var2)
    local data = {
        var1 = var1,
        var2 = var2,
    }
    vim.fn.writefile({ vim.fn.json_encode(data) }, path)
end

-- Load values
function M.load()
    if vim.fn.filereadable(path) == 0 then
        return '', '' -- return defaults if file doesn't exist
    end

    local file = vim.fn.readfile(path)
    if #file == 0 then
        return '', ''
    end

    if #file == 0 then
        return '', ''
    end
    local data = vim.fn.json_decode(file[1])
    return data.var1 or '', data.var2 or ''
end

function M.setup()
    local bs, rs = M.load()
    vim.g.my_build_script = bs
    vim.g.my_exec_script = rs

    -- Run build scripts
    vim.api.nvim_create_user_command('Setbs', function(opts)
        local arg = opts.args
        vim.g.my_build_script = arg
        M.save(vim.g.my_build_script, vim.g.my_exec_script)
        print("Mache: '" .. vim.g.my_build_script .. "' saved as build script.")
    end, { nargs = 1 })

    vim.api.nvim_create_user_command('Setrs', function(opts)
        local arg = opts.args
        vim.g.my_exec_script = arg
        M.save(vim.g.my_build_script, vim.g.my_exec_script)
        print("Mache: '" .. vim.g.my_exec_script .. "' saved as exec script.")
    end, { nargs = 1 })

    vim.keymap.set('n', '<leader>mb', function()
        if vim.g.my_build_script ~= '' then
            vim.cmd('!' .. vim.g.my_build_script)
        else
            print 'NO BUILD SCRIPT SET'
        end
    end, { desc = 'Mache: Run your build script' })

    vim.keymap.set('n', '<leader>mr', function()
        if vim.g.my_exec_script ~= '' then
            vim.cmd('!' .. vim.g.my_exec_script)
        else
            print 'NO EXEC SCRIPT SET'
        end
    end, { desc = 'Mache: Run your exec script' })
end

return M
