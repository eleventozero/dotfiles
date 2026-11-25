local M = {}

local runners = {
  python = function(file)
    return { "python3", file }
  end,

  kotlin = function(file)
    local jar = vim.fn.tempname() .. ".jar"

    local compile = "kotlinc "
      .. vim.fn.shellescape(file)
      .. " -include-runtime -d "
      .. vim.fn.shellescape(jar)

    local run = "java -jar "
      .. vim.fn.shellescape(jar)

    return {
      "bash",
      "-c",
      compile .. " && " .. run
        .. "; status=$?; rm -f "
        .. vim.fn.shellescape(jar)
        .. "; exit $status",
    }
  end,
}

function M.run()
  local runner = runners[vim.bo.filetype]

  if not runner then
    vim.notify("No runner for " .. vim.bo.filetype, vim.log.levels.WARN)
    return
  end

  vim.cmd("write")

  local file = vim.fn.expand("%:p")

  Snacks.terminal(runner(file), {
    cwd = vim.fn.fnamemodify(file, ":h"),
    interactive = true,
    auto_close = false,
  })
end

return M
