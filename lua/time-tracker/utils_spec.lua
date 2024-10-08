local utils = require("time-tracker/utils")

describe("is_trackable_buffer", function()
  it("returns false for invalid buffers", function()
    local trackable = utils.is_trackable_buffer(1234)
    expect(trackable).toBe(false)
  end)

  it("returns false for unlisted file buffers", function()
    local buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, "/dev/null")
    local trackable = utils.is_trackable_buffer(buf)
    expect(trackable).toBe(false)
    vim.api.nvim_buf_delete(buf, { force = true })
  end)

  it("returns false for non-file buffers", function()
    local buf = vim.api.nvim_create_buf(true, false)
    local trackable = utils.is_trackable_buffer(buf)
    expect(trackable).toBe(false)
  end)

  it("returns true for valid buffers", function()
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, "/dev/null")
    local trackable = utils.is_trackable_buffer(buf)
    expect(trackable).toBe(true)
  end)
end)

describe("format_duration", function()
  it("formats value as HH:MM:SS", function()
    local duration = 3600
    local formatted = utils.format_duration(duration)
    expect(formatted).toBe("01:00:00")
  end)
end)

describe("format_path_friendly", function()
  it("formats path", function()
    local path = "$HOME/foo/bar"
    local formatted = utils.format_path_friendly(path)
    expect(formatted).toBe("~/foo/bar")
  end)
end)

describe("in_array", function()
  it("returns true if value is in array", function()
    local array = { "foo", "bar", "baz" }
    local value = "foo"
    expect(utils.in_array(value, array)).toBe(true)
  end)
  it("returns false if value is not in array", function()
    local array = { "foo", "bar", "baz" }
    local value = "qux"
    expect(utils.in_array(value, array)).toBe(false)
  end)
end)
