--Training Field
function c511000659.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511000659.atop)
	c:RegisterEffect(e2)
end
function c511000659.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetAttacker()
	local p=tg:GetControler()
	if Duel.GetFieldGroupCount(p,LOCATION_MZONE,0)>1 and Duel.SelectYesNo(p,aux.Stringid(511000659,0)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TARGET)
		local g=Duel.SelectMatchingCard(p,nil,p,LOCATION_MZONE,0,1,1,tg)
		if g:GetCount()>0 then
			--Duel.ChangeAttackTarget(g:GetFirst())
			Duel.CalculateDamage(tg,g:GetFirst())
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(300)
			tg:RegisterEffect(e1)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
			tg:RegisterEffect(e1)
			local e2=e1:Clone()
			g:GetFirst():RegisterEffect(e2)
		end
	end
end
