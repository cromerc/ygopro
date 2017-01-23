--Tao the chanter
--Scripted by GameMaster (GM)
local id,cod=511005607,c511005607
function cod.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
    e1:SetOperation(cod.operation)
    c:RegisterEffect(e1)
end
function cod.tg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAttribute,tp,0,LOCATION_MZONE,1,nil,ATTRIBUTE_LIGHT) end
end
function cod.operation(e,tp,eg,ep,ev,re,r,rp)
   local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,0,LOCATION_MZONE,nil,ATTRIBUTE_LIGHT)
    local tc=g:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
        e1:SetValue(ATTRIBUTE_DARK)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        tc:RegisterEffect(e1,true)
        tc=g:GetNext()
    end
end
