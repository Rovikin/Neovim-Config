local M = {}

function M.GithubRepoPicker()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local home_dir = vim.fn.expand("~")
    local dev_repos_dir = home_dir .. "/dev_repos"

    -- Pastikan direktori ~/dev_repos/ ada                          vim.fn.mkdir(dev_repos_dir, "p")                            
    -- Perintah gh CLI untuk mengambil daftar repo.                 -- Outputnya diformat "nama_repo:clone_url:deskripsi" untuk memudahkan parsing.
    local gh_command = "gh repo list --json name,url,description --limit 100 --jq '.[] | \"\\(.name):\\(.url):\\(.description)\"' | sort"

    telescope.pickers.new({}, {                                         prompt_title = "GitHub Repositories",
        -- Menggunakan 'bash -c' untuk eksekusi string perintah lengkap.
        finder = require("telescope.finders").new_oneshot_job({
            command = { "bash", "-c", gh_command },
        }),
        sorter = require("telescope.sorters").get_fuzzy_file_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            -- Menimpa aksi default 'select_default' (biasanya Enter)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr) -- Tutup picker Telescope
                local selection = action_state.get_selected_entry()                                                                             local full_entry = selection.value
                                                                                -- Parsing data repo dari format "nama:url:deskripsi"                                                                           local name, url, description = full_entry:match("^(.-):(.+):(.*)$")                                             
                -- Validasi hasil parsing
                if not name or not url then                                         vim.notify("Error: Tidak bisa parsing info repo dari '" .. full_entry .. "'.", vim.log.levels.ERROR)
                    return
                end

                local clone_dir = dev_repos_dir .. "/" .. name

                -- Cek apakah repo sudah pernah dikloning
                if vim.fn.isdirectory(clone_dir) == 1 then                          vim.notify("Repo '" .. name .. "' sudah ada. Membuka direktori yang sudah ada.", vim.log.levels.INFO)
                    vim.api.nvim_set_current_dir(clone_dir)
                    vim.cmd("NvimTreeToggle")
                    return
                end

                -- Info ke user bahwa proses kloning dimulai
                vim.notify("Mulai kloning '" .. name .. "' dari '" .. url .. "'...", vim.log.levels.INFO)

                local cmd = "gh"
                -- Argumen untuk gh repo clone: <url> dan <nama_direktori_lokal>
                local args = {"repo", "clone", url, name}

                -- Eksekusi perintah 'gh repo clone' secara asinkron menggunakan vim.uv.spawn
                vim.uv.spawn(cmd, {                                                 args = args,
                    cwd = dev_repos_dir, -- Jalankan perintah 'gh clone' dari direktori ~/dev_repos/
                    stdout = vim.uv.new_pipe(false), -- Buat pipe untuk output standar
                    stderr = vim.uv.new_pipe(false), -- Buat pipe untuk error standar
                }, function(err, exit_code, signal)                                 if err then
                        vim.api.nvim_err_writeln("Error saat menjalankan gh clone: " .. err)                                                            vim.notify("Gagal kloning repo: " .. name .. ". Error: " .. err, vim.log.levels.ERROR)
                        return                                                      end

                    if exit_code ~= 0 then                                              vim.api.nvim_err_writeln("gh clone keluar dengan kode: " .. exit_code .. " untuk " .. name)                                     vim.notify("Gagal kloning repo: " .. name .. ". Cek Termux/GitHub CLI untuk detail.", vim.log.levels.ERROR)                                                                                     return
                    end

                    -- Kloning berhasil: pindah direktori dan buka NvimTree
                    vim.api.nvim_set_current_dir(clone_dir)                         vim.cmd("NvimTreeToggle")
                    vim.notify("Berhasil kloning dan membuka '" .. name .. "'.", vim.log.levels.INFO)
                end)
            end)
            return true
        end,
    }):find()
end

return M
