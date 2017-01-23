--Darkness 1
function c95000008.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c95000008.condition)
	e1:SetTarget(c95000008.target)
	e1:SetOperation(c95000008.operation)
	c:RegisterEffect(e1)
	--
	local e2=e1:Clone()
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetCondition(c95000008.condition2)
	c:RegisterEffect(e2)
end
c95000008.mark=3
function c95000008.filter(c)
    return c:IsCode(95000004) and c:IsFaceup() and not c:IsStatus(STATUS_DISABLED)
end
function c95000008.condition(e,tp,eg,ep,ev,re,r,rp)
    local re=re:GetHandler()
	return re:IsCode(95000005) and not re:IsStatus(STATUS_DISABLED)
	and Duel.IsExistingMatchingCard(c95000008.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c95000008.condition2(e,tp,eg,ep,ev,re,r,rp)
    local re=re:GetHandler()
	return re:IsSetCard(0x26ed) and re:IsType(2004) and e:GetHandler():GetFlagEffect(95000008)>0
end
function c95000008.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end 
	Duel.SetTargetParam(2000)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2000)
end
function c95000008.operation(e,tp,eg,ep,ev,re,r,rp)
    local d,p=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,d,REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(95000008,RESET_EVENT+0x1fe0000,0,1)
end
function c95000008.con1(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsLocation(LOCATION_HAND) and Duel.GetTurnCount()==1
end
function c95000008.op1(e,tp,eg,ep,ev,re,r,rp)
    Duel.DisableShuffleCheck()
    Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_RULE)
end
