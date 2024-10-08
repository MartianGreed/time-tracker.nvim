local TimeTracker = require("time-tracker/tracker").TimeTracker
local SqliteSession = require("time-tracker/sqlite_session").SqliteSession

describe("TimeTracker", function()
  local config = {
    data_file = "/tmp/time-tracker.sqlite",
    tracking_events = { "BufEnter" },
    tracking_timeout_seconds = 1,
  }

  before_each(function()
    os.remove(config.data_file)
  end)

  it("creates a new instance", function()
    local session = SqliteSession:new(config)
    local tracker = TimeTracker:new(session)
    expect(tracker.impl.config).toBe(config)
  end)

  it("starts a session", function()
    local session = SqliteSession:new(config)
    local tracker = TimeTracker:new(session)
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, "/dev/null")
    tracker:start_session()
    expect(tracker.impl.current_session).n.toBe(nil)
  end)
end)
