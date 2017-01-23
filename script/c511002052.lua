--魔法効果の矢
function c511002052.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002052.cost)
	e1:SetTarget(c511002052.target)
	e1:SetOperation(c511002052.activate)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
end
function c511002052.cfilter(c,tp)
	return c:IsRace(RACE_ZOMBIE) and Duel.IsExistingTarget(c511002052.filter,tp,0,LOCATION_MZONE,1,nil)
end
function c511002052.filter(c)
	return c:IsFaceup() and not c:IsRace(RACE_ZOMBIE)
end
function c511002052.cost(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(1)
	return true
end
function c511002052.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511002052.filter(chkc) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c511002052.cfilter,1,nil,tp)
	end
	local rg=Duel.SelectReleaseGroup(tp,c511002052.cfilter,1,1,nil,tp)
	local atk=rg:GetFirst():GetTextAttack()
	if atk<0 then atk=0 end
	Duel.Release(rg,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002052.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetTargetParam(atk)
end
function c511002052.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetLabel(atk)
		e1:SetOwnerPlayer(tp)
		e1:SetOperation(c511002052.atkop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511002052.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=e:GetLabel()
	if Duel.GetTurnPlayer()==e:GetOwnerPlayer() then
		if c:GetAttack()>0 then
			Duel.Hint(HINT_CARD,0,511002052)
			local e1=Effect.CreateEffect(e:GetOwner())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-atk)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e1)
		end
	end
end
