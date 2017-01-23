--Darkness 1
function c95000006.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c95000006.condition)
	e1:SetTarget(c95000006.target)
	e1:SetOperation(c95000006.operation)
	c:RegisterEffect(e1)
	--
	local e2=e1:Clone()
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetCondition(c95000006.condition2)
	c:RegisterEffect(e2)
end
c95000006.mark=1
function c95000006.filter(c)
    return c:IsCode(95000004) and c:IsFaceup() and not c:IsStatus(STATUS_DISABLED)
end
function c95000006.condition(e,tp,eg,ep,ev,re,r,rp)
    local re=re:GetHandler()
	return re:IsCode(95000005) and not re:IsStatus(STATUS_DISABLED)
	and Duel.IsExistingMatchingCard(c95000006.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c95000006.condition2(e,tp,eg,ep,ev,re,r,rp)
    local re=re:GetHandler()
	return re:IsSetCard(0x26ed) and re:IsType(2004) and e:GetHandler():GetFlagEffect(95000006)>0
end
function c95000006.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end 
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c95000006.operation(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local tc=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	e:GetHandler():RegisterFlagEffect(95000006,RESET_EVENT+0x1fe0000,0,1)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c95000006.con1(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_HAND) and Duel.GetTurnCount()==1
end
function c95000006.op1(e,tp,eg,ep,ev,re,r,rp)
    Duel.DisableShuffleCheck()
    Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_RULE)
end
