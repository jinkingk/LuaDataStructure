----@class ListNode 链表节点
local ListNode = class()

---@param data any 节点数据
---@param next ListNode 指向下一节点
function ListNode:ctor(data)
    self.data = data
    self.next = nil
end

return ListNode