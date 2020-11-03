---https://blog.codingnow.com/cloud/LuaOO
--保存类类型的虚表
local _class = {}

function class(super)
    local class_type = {}
    --构造函数
    class_type.ctor = false
    --父类
    class_type.super = super
    --定义new函数 可以通过o.new(...)创建对象
    class_type.new = function(...)
        local obj = {}
        do
            --先声明再使用
            local create
            --递归函数 所有父类自上而下创建和构造
            create = function(c,...)
                if c.super then
                    create(c.super,...)
                end
                if c.ctor then
                    c.ctor(obj,...)
                end
            end
            --创建类
            create(class_type,...)
        end
        setmetatable(obj,{__index=_class[class_type]})
        --返回obj对象
        return obj
    end
    --虚表
    local vtbl = {}
    --设置虚表为class_type的元表
    _class[class_type] = vtbl
    --class_type的__newindex 在vtbl上进行
    setmetatable(class_type,{__newindex=
           function (t,k,v)
               vtbl[k] = v
           end
    })

    if super then
        --给vtbl设置源表,在vtbl上找不到的值会去父类中寻找
        setmetatable(vtbl,{__index=
               function(t,k)
                    local ret = _class[super][k]
                    vtbl[k] = ret
                    return ret
                end
        })
    end
    return class_type
end