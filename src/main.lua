-require("class")



local function LinkedListTest()
    local LinkedList = require("linked_list.LinkedList")
    local list = LinkedList.new()
    for i = 1, 4 do
        list:Insert(i,i-1)
    end
    list:Remove(3)
    list:Remove(1)
    list:Remove(0)
    list:Print()
end

local function main()
    LinkedListTest()
end

main()