--Mech Mole Zombie (DOR)
--Keddy was here
local id,cod=511005612,c511005612
function cod.initial_effect(c)
	--Zombifi
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetOperation(cod.zop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_FLIP)
	e2:SetCondition(cod.zcon)
	e2:SetOperation(cod.zop)
	c:RegisterEffect(e2)
end
function cod.zcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>4 and ph<100
end
function cod.zop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local c=e:GetHandler()
	local ag=a:GetAttackableTarget()
	if a:IsAttackable() and not a:IsImmuneToEffect(e) and ag:IsContains(c) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_ZOMBIE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e1)
	end
end