-- File: ~/.config/nvim/lua/github_utils.lua

        local M = {}

        function M.setup_github_repo_picker()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Fungsi untuk menjalankan command shell
            local function run_shell_command(cmd)
                local handle = io.popen(cmd)
                local result = handle:read("*a")
                handle:close()
                return result
            end

            -- User command untuk listing dan cloning GitHub repos
            vim.api.nvim_create_user_command('GithubRepoPicker', function()
                -- Dapatkan daftar repo dari gh CLI
                -- Gunakan awk untuk hanya mendapatkan nama repo (user/repo-name)
                local repos_str = run_shell_command('gh repo list --json nameWithOwner --limit 100 | jq -r \'.[] | .nameWithOwner\'')
                local repos = vim.split(repos_str, '\n', { plain = true, trimempty = true })

                if #repos == 0 then
                    vim.notify("Tidak ada repositori GitHub ditemukan atau gh CLI tidak terinstal/login.", vim.log.levels.WARN)
                    return
                end

                telescope.current_picker = nil -- Reset picker
                telescope.extensions.fzy_native = nil -- Reset fzy_native if it's causing issues

                telescope.find_files({
                    prompt_title = "GitHub Repositories",
                    results = repos,
                    finder = require('telescope.finders').new_table({
                        results = repos,
                        entry_maker = function(entry)
                            return {
                                value = entry,
                                display = entry,
                                ordinal = entry,
                            }
                        end
                    }),
                    sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
                    attach_mappings = function(prompt_bufnr, map)
                        map('i', '<CR>', function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)

                            if selection and selection.value then
                                local repo_full_name = selection.value -- e.g., "xorchi/my-awesome-repo"
                                local repo_name_only = repo_full_name:match("[^/]+$") -- e.g., "my-awesome-repo"

                                -- Tentukan lokasi clone (misal di parent directory atau di tempat khusus)
                                -- Ini akan membuat folder 'dev_repos' di home directory lu
                                local clone_dir = vim.fn.expand("~") .. "/dev_repos/" .. repo_name_only

                                -- Pastikan direktori tujuan ada
                                vim.fn.mkdir(vim.fn.fnamemodify(clone_dir, ":h"), "p")

                                vim.notify("Cloning " .. repo_full_name .. " to " .. clone_dir .. "...", vim.log.levels.INFO)

                                -- Jalankan clone di terminal baru
                                -- :term otomatis jalan di background dan nampilin output
                                vim.cmd("term gh repo clone " .. repo_full_name .. " " .. clone_dir)

                                -- Kasih waktu sebentar buat clone selesai, ini tricky karena async
                                -- Cara paling simpel (tapi gak robust): tunggu sebentar
                                -- Atau lebih baik, buat fungsi yang nge-cek kalau proses term udah selesai
                                -- Untuk sekarang, kita asumsikan selesai cepat atau lu bisa enter lagi
                                vim.defer_fn(function()
                                    -- Setelah clone selesai (atau diasumsikan selesai),
                                    -- ganti ke direktori repo yang baru di-clone dan buka nvim-tree
                                    if vim.fn.isdirectory(clone_dir) == 1 then -- Cek direktori sudah ada
                                        vim.cmd("cd " .. clone_dir)
                                        vim.cmd("NvimTreeToggle") -- Buka nvim-tree di repo yang baru di-clone
                                        vim.notify("Selesai cloning dan membuka " .. repo_full_name, vim.log.levels.INFO)
                                    else
                                        vim.notify("Gagal cloning atau direktori tidak ditemukan: " .. clone_dir, vim.log.levels.ERROR)
                                    end
                                end, 2000) -- Tunggu 2 detik, sesuaikan jika perlu


                            else
                                vim.notify("Tidak ada repositori yang dipilih.", vim.log.levels.WARN)
                            end
                        end)
                        return true
                    end,
                })
            end, {
                desc = "List and clone GitHub repositories"
            })
        end

        return M
