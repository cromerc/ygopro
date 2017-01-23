--Courageous Charge
function c511000999.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c511000999.cost)
	e1:SetTarget(c511000999.target)
	e1:SetOperation(c511000999.activate)
	c:RegisterEffect(e1)
end
function c511000999.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511000999.filter(c)
	return c:IsFaceup() and c:IsAttackBelow(1000)
end
function c511000999.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000999.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000999.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000999.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000999.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EVENT_BATTLE_DAMAGE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetOperation(c511000999.damop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511000999.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local def=c:GetDefense()
	if ep~=tp then
		Duel.Damage(1-tp,def,REASON_EFFECT)
	end
end
