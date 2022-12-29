local GlobalTypes = require(game.ReplicatedFirst.ClientClasses.ClientApiT)

local Debris = game:GetService("Debris")

local Assertion = shared.CLIENTAPI.include("assertion")

local ConsoleUI: ScreenGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("ConsoleGUI")
local OutputFrame: Frame = ConsoleUI:WaitForChild("Frame")

local OutputMessage: Frame = game.ReplicatedStorage.ClientResources:WaitForChild("OutputMessage")

local Icons = {
    [Enum.MessageType.MessageOutput] = "rbxassetid://11857057232";
    [Enum.MessageType.MessageInfo] = "rbxassetid://11856999902";
    [Enum.MessageType.MessageError] = "rbxassetid://11856999750";
    [Enum.MessageType.MessageWarning] = "rbxassetid://11857000103"
}

local DefaultConsoleFormatColor = Color3.new(1,1,1)

local module = {}

function module.message(msg: string, formatOptions: GlobalTypes.ConsoleFormatOptions)
    formatOptions = formatOptions or {}
    local Color = formatOptions.Color or DefaultConsoleFormatColor
    local IconType = formatOptions.IconType or Enum.MessageType.MessageOutput
    local FrameInstance = OutputMessage:Clone()
    local TextLabel: TextLabel = FrameInstance.TextLabel
    TextLabel.Text = msg
    FrameInstance.Parent = OutputFrame
    Debris:AddItem(FrameInstance, 10)
end

function module.log(...)
    local tuple = {...}
    local message = "[CONSOLE.LOG]: "..tostring(tuple[1])
    if #tuple > 1 then
        for i = 2,#tuple do
            message = message .. " << " .. tuple[i]
        end
    end
    print(message)
end

function module.warn(...)
    local tuple = {...}
    local message = "[CONSOLE.WARN]: "..tostring(tuple[1])
    if #tuple > 1 then
        for i = 2,#tuple do
            message = message .. " << " .. tuple[i]
        end
    end
    warn(message)
end

--console error levels
module.errorindex = {
    "Assertion Error";
    "Movement System Error";
    "Weapon System Error";
    "Missing Module Error"; -- Occurs when a module is missing from CLIENTAPI or CompileClient
    "CLIENTAPI Module Error";
    "Runtime Module Error";
    "Halted";
    "LongLoad";
    "PreloadError";
    "NotAvailable";
}

function module.getErrorDescription(i: number)
    return module.errorindex[i]
end

function module.error(msg: string, level: number)
    error(string.format("[CONSOLE.ERROR: %s]: %s", level, msg))
end

return module