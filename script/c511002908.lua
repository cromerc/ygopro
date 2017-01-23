--Rose Blizzard
function c511002908.initial_effect(c)
	--Negate Damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002908.condition)
	e1:SetTarget(c511002908.target)
	e1:SetOperation(c511002908.activate)
	c:RegisterEffect(e1)
end
function c511002908.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c511002908.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re and re:GetHandler():IsLocation(LOCATION_MZONE) end
	Duel.SetTargetCard(eg)
end
function c511002908.activate(e,tp,eg,ep,ev,re,r,rp,val,r,rc)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511002908.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetAttack()/2)
		tc:RegisterEffect(e1)
	end
end
function c511002908.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then e:SetLabel(val) return 0
	else return val end
end
