--Moonlight Dance
function c511001292.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001292.condition)
	e1:SetTarget(c511001292.tg)
	e1:SetOperation(c511001292.op)
	c:RegisterEffect(e1)
end
function c511001292.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsSetCard(0xdf)
end
function c511001292.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(aux.TRUE,1-tp,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetFieldGroup(1-tp,aux.TRUE,tp,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c511001292.op(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetFieldGroup(1-tp,LOCATION_MZONE,nil)
	if sg:GetCount()>0 then
		Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
		local tc=sg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
			e1:SetValue(tc:GetAttack()/2)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
			e2:SetValue(tc:GetDefense()/2)
			tc:RegisterEffect(e2)
			tc=sg:GetNext()
		end
	end
end
