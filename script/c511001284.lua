--Phantom Fog Blade
function c511001284.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001284.condition)
	e1:SetTarget(c511001284.target)
	e1:SetOperation(c511001284.activate)
	c:RegisterEffect(e1)
end
function c511001284.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001284.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c511001284.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		if Duel.NegateAttack(tc) then
			c:SetCardTarget(tc)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetCondition(c511001284.rcon)
			tc:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_ATTACK)
			tc:RegisterEffect(e2,true)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
			e3:SetValue(1)
			tc:RegisterEffect(e3)
		end
	end
end
function c511001284.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
