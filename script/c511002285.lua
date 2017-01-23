--Urubonus, the Avatar of Malice
function c511002285.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79491903,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002285.atkcon)
	e1:SetOperation(c511002285.atkop)
	c:RegisterEffect(e1)
end
function c511002285.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	if a==c then a=Duel.GetAttackTarget() end
	return a and a:IsRelateToBattle()
end
function c511002285.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc:IsFacedown() or not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-300)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(-300)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
end
