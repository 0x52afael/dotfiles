return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            -- Installs the debug adapters for you
            "mason-org/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        keys = {
            {
                mode = "n",
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Start/Continue Debugging" ,
            },
            {
                mode = "n",
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                 desc = "Step Over" ,
            },
            {
                mode = "n",
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                 desc = "Step Into" ,
            },
            {
                mode = "n",
                "<leader>dO",
                function()
                    require("dap").step_out()
                end,
                 desc = "Step Out" ,
            },
            {
                mode = "n",
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                 desc = "Toggle Breakpoint" ,
            },
            {
                mode = "n",
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                 desc = "Set Conditional Breakpoint" ,
            },

            {
                mode = "n",
                "<leader>7",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                end,
                 desc = "Set Log Point" ,
            },
            {
                mode = "n",
                "<leader>8",
                function()
                    require("dap").terminate()
                end,
                 desc = "Terminate Debugging" ,
            },
            {
                mode = "n",
                "<leader>9",
                function()
                    require("dap").restart()
                end,
                 desc = "Restart Debugging" ,
            },
            {
                mode = "n",
                "<leader>on",
                function()
                    require("mini.notify").show_history()
                end,
                 desc = "Show MiniNotify history" ,
            },
            {
                mode = { "n", "v" },
                "<leader>dt",
                function()
                    require("dap-python").test_method()
                end,
                 desc = "Debug nearest test" ,
            },

            {
                mode = { "n", "v" },
                "<leader>dr",
                function()
                    require("dap").open({ reset = true })
                end,
                 noremap = true, desc = "Reload debugger UI" ,
            },
            {
                mode = "n",
                "<leader>77",
                function()
                    require("dapui").toggle()
                end,
                desc = "Debug: See last session result.",
            },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("mason-nvim-dap").setup({
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    "debugpy",
                },
            })

            dapui.setup({
                windows = {
                    indent = 1,
                },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.33 },
                            { id = "watches", size = 0.33 },
                            { id = "repl", size = 0.33 },
                            -- { id = "console", size = 0.34 },
                        },
                        position = "bottom",
                        size = 15,
                    },
                },
                mappings = {
                    edit = "e",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    repl = "r",
                    toggle = "t",
                },
            })

            local dap_python = require("dap-python")
            dap_python.setup("python3")
            dap_python.test_runner = "pytest"
            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = "",
            })

            -- Change breakpoint icons
            vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
            vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
            local breakpoint_icons = vim.g.have_nerd_font
                    and {
                        Breakpoint = "",
                        BreakpointCondition = "",
                        BreakpointRejected = "",
                        LogPoint = "",
                        Stopped = "",
                    }
                or {
                    Breakpoint = "●",
                    BreakpointCondition = "⊜",
                    BreakpointRejected = "⊘",
                    LogPoint = "◆",
                    Stopped = "⭔",
                }
            for type, icon in pairs(breakpoint_icons) do
                local tp = "Dap" .. type
                local hl = (type == "Stopped") and "DapStop" or "DapBreak"
                vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
            end

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close

            require("nvim-dap-virtual-text").setup({
                commented = true,
            })
            dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-jest",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-python",
            "rcasia/neotest-java",
            "codymikol/neotest-kotlin",
        },
        config = function()
            require("neotest").setup({
                discovery = {
                    enabled = false,
                },
                adapters = {
                    require("neotest-java"),
                    require("neotest-kotlin"),
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        python = "python3",
                        runner = "pytest",
                        pytest_discover_instances = true,
                        is_test_file = function(file_path)
                            return vim.startswith(file_path, "test_") or file_path:match("tests?/.*%.py$")
                        end,
                    }),
                },
            })
        end,
    },
}
