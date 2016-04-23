--Diamond Head Dragon
function c140000076.initial_effect(c)
        c:EnableReviveLimit()
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
        e1:SetCode(EFFECT_SPSUMMON_CONDITION)
        e1:SetValue(aux.FALSE)
        c:RegisterEffect(e1)
end