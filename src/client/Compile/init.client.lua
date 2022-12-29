--[[

Script written by nerdakus#4764

desc
    This script is essentially what starts the game.
    It takes modules and loads them into the local environment which is then given to the modules to handle data.
    The system attempts to keep this internal without exposing so that intruders can't make changes or read data.
desc end

version
    0000.000.0001 -> Creation
    0000.000.0002 -> Script compiling
    0000.000.0003 -> 
version end


]]--

local CompileConfig = require(script:WaitForChild("config"))

local CompileClient: Folder = game.ReplicatedFirst:WaitForChild("CompileClient")
local SharedAPI: Folder = game.ReplicatedFirst:WaitForChild("ClientAPI")
local Remote: Folder = game.ReplicatedStorage:WaitForChild("FrameworkRemotes")

local ClientCompileT = require(game.ReplicatedFirst.ClientStructs.ClientCompileT)

local Environment: ClientCompileT.ClientCompiler = {}
local Loading = {}

local SharedAPICompiled = {}
shared.CLIENTAPI = SharedAPICompiled

function SharedAPICompiled.include(Name)
    local Module = SharedAPICompiled[Name]
    if Module then
        return Module
    else
        local ConsoleQuick = SharedAPICompiled.console
        assert(ConsoleQuick, "Missing console.lua!!! Check directory game.ReplicatedFirst.ClientAPI.console to see if the module exists.")
        ConsoleQuick.error("Missing Module!!!\nModule '"..Name..".lua' could not be found in game.ReplicatedFirst.ClientAPI", 4)
    end 
end

if CompileConfig.VerboseCompiling then
    print("[VANILLA PRINT]: Loading SharedAPI Folder...")
end

for _, ToCompile: ModuleScript in pairs(SharedAPI:GetChildren()) do
    SharedAPICompiled[ToCompile.Name] = require(ToCompile)
    ToCompile:Destroy()
end

SharedAPI:Destroy()

assert(SharedAPICompiled.assertion, "Missing assertion.lua!!! Check directory game.ReplicatedFirst.ClientAPI.assertion to see if the module exists.")
local assert = SharedAPICompiled.assertion

local console = assert.new(SharedAPICompiled.console):cNil():FinalizeRaise()
if CompileConfig.VerboseCompiling then
    console.log("Loaded CLIENTAPI Folder, Now loading CompileClient folder...")
end

for _, ToCompile: ModuleScript in pairs(CompileClient:GetChildren()) do
    local Data: ClientCompileT.ClientCompileFunction = require(ToCompile)
    Loading[#Loading+1] = Data
    ToCompile:Destroy()
end

for _,CompileData: ClientCompileT.ClientCompileFunction in pairs(Loading) do
    local CompiledData: ClientCompileT.ClientCompiledScript = CompileData(Environment)
    console.log("Loaded '"..CompiledData.Name.."'")
end

CompileClient:Destroy()

table.freeze(shared.CLIENTAPI)