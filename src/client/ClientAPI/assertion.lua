local HttpService = game:GetService("HttpService")

local Console = shared.CLIENTAPI.console

local module = {}
module.__index = module

function module.new(Value: any, ErrorOnFail: boolean, DebugName: string?)
    local self = {}

    self.Eval = Value
    self.Status = true
    self.Checked = 0
    self.Message = ""
    self.Name = DebugName or HttpService:GenerateGUID(false)
    --self.ErrorOnFail = ErrorOnFail and true or false
    --Commented due to overloads available by FinalizeRaise

    return setmetatable(self, module)
end

function module:True(statement, message)
    if self.Status then
        self.Checked += 1

        local StatementCheck = (statement and true or false)
        if not StatementCheck then
            self.Status = false
            self.Message = "[ASSERTION FAIL]\nFailed in chain link "..self.Checked..".\nCheck Type was ["..message.."]"
            if self.ErrorOnFail then
                
            end
        end
    end

    return self
end

function module:cNil()
    return self:True(self.Eval ~= nil, "NilCheck")
end

function module:cType(sType: string)
    return self:True(typeof(self.Eval) == sType, "TypeCheck(\""..sType.."\")")
end

function module:Finalize()
    return self.Eval
end

function module:FinalizeWithLog()
    return {
        Value = self.Eval;
        Status = self.Status;
        Message = self.Message;
        CheckNum = self.Checked;
    }
end

function module:FinalizeRaise()
    if not self.Status then
        Console.error(self.Message, 1)
    end
    return self.Eval
end

function module:FinalizeMSG(msg:string)
    if not self.Status then
        Console.error(msg, 1)
    end
    return self.Eval
end

return module