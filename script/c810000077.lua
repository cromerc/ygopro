--Aquarium Lighting
--scripted by: UnknownGuest
function c810000077.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c810000077.atkup)
	c:RegisterEffect(e2)
end
function c810000077.atkup(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	c810000077.adup(a,e:GetHandler())
	c810000077.adup(d,e:GetHandler())
end
function c810000077.adup(c,oc)
	if not c:IsSetCard(0x325) then return end
	local e1=Effect.CreateEffect(oc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(c:GetAttack()*2)
	c:RegisterEffect(e1)
end
