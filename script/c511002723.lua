--Red Soul
function c511002723.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCost(c511002723.cost)
	e1:SetTarget(c511002723.target)
	e1:SetOperation(c511002723.activate)
	c:RegisterEffect(e1)
end
function c511002723.cfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_MONSTER)
end
function c511002723.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511002723.filter(c)
	return c:IsFaceup() and c:GetFlagEffect(70899775)==0
end
function c511002723.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002723.filter(chkc) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511002723.cfilter,tp,LOCATION_HAND,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511002723.cfilter,tp,LOCATION_HAND,0,2,2,nil)
	local sum=g:GetSum(Card.GetAttack)
	Duel.SendtoGrave(g,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002723.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetParam(sum)
end
function c511002723.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(c511002723.damval)
		e1:SetLabel(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e3)
	end
end
function c511002723.damval(e,re,val,r,rp,rc)
	local dam=val-e:GetLabel()
	if dam>=0 then
		return dam
	else
		return 0
	end
end
