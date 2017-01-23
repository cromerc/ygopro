--Doom Virus Dragon
function c170000150.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,57728570,11082056,true,true)
	--Doom Virus (Faceup)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)	
	e1:SetOperation(c170000150.desop)
	c:RegisterEffect(e1)
	--check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_MSET)
	e2:SetOperation(c170000150.chkop)
	c:RegisterEffect(e2)
end
c170000150.material_trap=57728570
function c170000150.filter(c,g,pg)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:IsDestructable() and not c:IsCode(170000150)
end
function c170000150.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c170000150.filter,tp,0,LOCATION_MZONE,nil)
	local conf=Duel.GetMatchingGroup(c170000150.filter2,tp,0,LOCATION_MZONE,nil)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
		g:Merge(conf)
	end
	Duel.Destroy(g,REASON_EFFECT)
end
function c170000150.filter2(c)
	return c:IsFacedown() and c:IsAttackAbove(1500) and c:IsDestructable()
end
function c170000150.chkop(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,0,LOCATION_MZONE,POS_FACEDOWN)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
	end
end
