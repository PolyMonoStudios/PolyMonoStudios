local socket = {}
local socketInstance = {}
socketInstance.__index = socketInstance

function socket.new()
    local self = {}

    return setmetatable(self, socketInstance)
end

return socket