local ClientStructs = require(script.Parent)

local ScriptData: ClientStructs.TypeScript = {
    Name = script.Name;
}

export type ClientCompiler = {
    [string]: ClientCompiledScript;
}

export type ClientCompileFunction = (ClientCompiler) -> ClientCompiledScript

export type ClientCompiledScript = {
    Version: number;
    Name: string;
    Description: string;
}

return ScriptData