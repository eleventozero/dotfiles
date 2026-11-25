return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "kotlin-language-server" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {
          cmd_env = {
            JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64",
          },
          init_options = {
            storagePath = vim.fn.stdpath("cache") .. "/kotlin-language-server",
          },
        },
      },
    },
  },
}
