local M = {}

-- RIGHT NOW, THIS IS A HACK.
-- NEOVIM LSP removes all marks when formatting.
-- This is a workaround to restore them.
--
-- TODO :: REMOVE THIS WHEN THE ISSUE IS FIXED.
-- TODO :: ISOLATE THE domain of the marks.
function M.format_buffer(bufnr)
  local function valid_mark(mark)
    return mark:match("^'[a-zA-Z]$")
  end

  local function mark_to_key(mark)
    return mark:sub(2, 2)
  end

  local function local_marks()
    local marks = {}

    for _, m in pairs(vim.fn.getmarklist(bufnr)) do
      local mark = m.mark
      if (valid_mark(mark)) then
        marks[mark_to_key(mark)] = m.pos[2]
      end
    end

    return marks
  end

  local function global_marks()
    local marks = {}

    for _, m in pairs(vim.fn.getmarklist()) do
      local mark = m.mark
      local mark_buffer = m.pos[1]

      if mark_buffer == bufnr and
          valid_mark(mark) then
        marks[mark_to_key(mark)] = m.pos[2]
      end
    end

    return marks
  end

  local function set_marks(marks)
    local actual_marks = vim.fn.getmarklist(bufnr)
    local max = vim.api.nvim_buf_line_count(bufnr)

    local_marks = marks

    for _, m in pairs(actual_marks) do
      local_marks[mark_to_key(m.mark)] = nil
    end

    for mark, line in pairs(local_marks) do
      if line then
        line = math.min(line, max)
        vim.api.nvim_buf_set_mark(bufnr, mark, line, 0, {})
      end
    end
  end


  local old_marks = { local_marks(), global_marks() }

  -- really format the buffer
  vim.lsp.buf.format { async = false }

  -- restore the marks first locally, then globally
  set_marks(old_marks[1])
  set_marks(old_marks[2])
end

return M
