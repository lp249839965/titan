local symtab = {}

symtab.__index = symtab

function symtab.new()
    return setmetatable({ blocks = {} }, symtab)
end

function symtab:open_block()
    table.insert(self.blocks, {})
end

function symtab:close_block()
    assert(#self.blocks > 0, "stack underflow")
    table.remove(self.blocks)
end

function symtab:add_symbol(name, decl)
    assert(#self.blocks > 0, "no blocks")
    local block = self.blocks
    block[#block][name] = decl
end

function symtab:find_symbol(name)
    local decl
    for i = #self.blocks, 1, -1 do
        decl = self.blocks[i][name]
        if decl then
            break
        end
    end
    return decl
end

return symtab