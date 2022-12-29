local HttpService = game:GetService("HttpService")

local function meta()
    local t = {}
    t.__index = t
    return t
end

local event = meta()
local connection = meta()

function event.new()
    local self = {}

    self.Connections = {}

    return setmetatable(self, event)
end

function event:invoke(...)
    for i, v in pairs(self.Connections) do
        task.spawn(function(...)
            v._body(...)
        end, ...)
    end
end

function event:plugin(body)
    return connection.new(body, self)
end

function connection.new(body, event)
    local self = {}

    self.Active = true

    self._eventid = HttpService:GenerateGUID(false)
    self._body = body
    self._event = event

    event.Connections[self._eventid] = self

    return setmetatable(self, connection)
end

function connection:unplug()
    if not self.Active then return end
    self.Active = false

    self._event.Connections[self._eventid] = nil
end

return event