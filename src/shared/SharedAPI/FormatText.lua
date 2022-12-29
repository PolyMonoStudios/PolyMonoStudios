local module = {}

local TextFormatDefault = '<stroke thickness="%s" color="rgb(%s,%s,%s)"><font color="rgb(%s,%s,%s)"><i><sc>%s</sc></i></font></stroke>'
local TextColorDefault = Color3.new(1, 1, 1)
local StrokeThicknessDefault = 1.3

export type FormatOptions = {
    color: Color3?;
    thickness: number?;
}

function module.default(text: string, formatOptions: FormatOptions)
    local color = formatOptions.color or TextColorDefault
    local thickness = formatOptions.thickness or StrokeThicknessDefault
    local r1,g1,b1 = color.R,color.G,color.B
    local r2,g2,b2 = math.max(r1-0.1,0),math.max(g1-0.1,0),math.max(b1-0.1,0)
    return TextFormatDefault:format(thickness,r1,g1,b1,r2,g2,b2,text)
end

return module