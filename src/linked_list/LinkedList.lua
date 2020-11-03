local ListNode = require("linked_list.ListNode")
---@class LinkedList 单链表
local LinkedList = class()

function LinkedList:ctor()
    --链表实际长度
    self.size = 0
    --头结点指针
    self.head = nil
    --尾结点指针
    self.tail = nil
end

---链表查找元素
---@param index number 查找位置
function LinkedList:Get(index)
    if index<0 or index>=self.size then
        error("index out of bounds")
    end
    local temp = self.head
    for i = 0, index-1 do
        temp = temp.next
    end
    return temp
end

---链表插入元素
---@param data any 插入元素
---@param index number 插入位置
function LinkedList:Insert(data,index)
    if index<0 or index>self.size then
        error("index out of bounds")
    end
    local insertNode = ListNode.new(data)
    if self.size == 0 then
        --空链表
        self.head = insertNode
        self.tail = insertNode
    elseif index == 0 then
        --插入头部
        insertNode.next = self.head
        self.head = insertNode
    elseif index == self.size then
        --插入尾部
        self.tail.next = insertNode
        self.tail = insertNode
    else
        --插入中间
        local preNode = self:Get(index-1)
        insertNode.next = preNode.next
        preNode.next = insertNode
    end
    self.size = self.size + 1
end

---链表删除元素
---@param index number 删除位置
function LinkedList:Remove(index)
    if index<0 or index>=self.size then
        error("index out of bounds")
    end
    local removeNode
    if index==0 then
        --删除头结点
        removeNode = self.head
        self.head = self.head.next
    else
        --删除其他节点
        local preNode = self:Get(index-1)
        removeNode = preNode.next
        preNode.next = preNode.next.next
    end
    self.size = self.size - 1
    return removeNode
end

function LinkedList:Print()
    local next = self.head
    while(next) do
        print(next.data)
        next = next.next
    end
end

return LinkedList