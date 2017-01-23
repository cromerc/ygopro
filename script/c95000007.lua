--Darkness 2
function c95000007.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c95000007.condition)
	e1:SetTarget(c95000007.target)
	e1:SetOperation(c95000007.operation)
	c:RegisterEffect(e1)
	--
	local e2=e1:Clone()
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetCondition(c95000007.condition2)
	c:RegisterEffect(e2)
end
c95000007.mark=2
function c95000007.filter(c)
    return c:IsCode(95000004) and c:IsFaceup() and not c:IsStatus(STATUS_DISABLED)
end
function c95000007.condition(e,tp,eg,ep,ev,re,r,rp)
    local re=re:GetHandler()
	return re:IsCode(95000005) and not re:IsStatus(STATUS_DISABLED)
	and Duel.IsExistingMatchingCard(c95000007.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c95000007.condition2(e,tp,eg,ep,ev,re,r,rp)
    local re=re:GetHandler()
	return re:IsSetCard(0x26ed) and re:IsType(2004) and e:GetHandler():GetFlagEffect(95000007)>0
end
function c95000007.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end 
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
end
function c95000007.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(4000)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:GetFirst():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(95000007,RESET_EVENT+0x1fe0000,0,1)
end
function c95000007.con1(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_HAND) and Duel.GetTurnCount()==1
end
function c95000007.op1(e,tp,eg,ep,ev,re,r,rp)
    Duel.DisableShuffleCheck()
    Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_RULE)
end
