local catch = {}

local catchInstance = {}
catchInstance.__index = catchInstance

local function catch()
    local new = {}

    new.CatchState = 0
    new.Bodies = {
        try = false;
        catch = false;
        finally = false;
    }
    
    return setmetatable(new, catchInstance)
end

function catchInstance:start()
    
end

return catch