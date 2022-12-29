local ClientCompileT = require(game.ReplicatedFirst.ClientStructs.ClientCompileT)

return function(env)
    local ReturnData: ClientCompileT.ClientCompiledScript = {
        Name = script.Parent;
        Description = "Test Script; Most likely unused.";
        Version = "0.0.1";
    }

    return ReturnData
end