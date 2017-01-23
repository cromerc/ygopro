--Unfair Treaty
--scripted by Shad3 & GameMaster (GM)
function c511005628.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCost(c511005628.cost)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(511005628,0))
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetCode(EFFECT_LPCOST_REPLACE)
e2:SetRange(LOCATION_SZONE)
e2:SetCondition(c511005628.condition)
e2:SetOperation(c511005628.operation)
c:RegisterEffect(e2)
end

function c511005628.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end

function c511005628.condition(e,tp,eg,ep,ev,re,r,rp)
    if re and tp==ep and re:GetActiveType()==TYPE_SPELL+TYPE_CONTINUOUS and e:GetHandler():GetFlagEffect(511005628)==0 then
        e:GetHandler():RegisterFlagEffect(511005628,RESET_EVENT,0,0)
        local res=Duel.CheckLPCost(1-ep,ev)
        e:GetHandler():ResetFlagEffect(511005628)
        return res
    end
    return false
end
function c511005628.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    c:RegisterFlagEffect(511005628,RESET_EVENT,0,0)
    Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
    Duel.PayLPCost(1-ep,ev)
    c:ResetFlagEffect(511005628)
end