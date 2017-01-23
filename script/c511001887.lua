--光のピラミッド
function c511001887.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Doom Virus (Faceup)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)	
	e2:SetOperation(c511001887.banop)
	c:RegisterEffect(e2)
	--check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_MSET)
	e3:SetOperation(c511001887.chkop)
	c:RegisterEffect(e3)
end
function c511001887.filter(c)
	return c:IsFaceup() and (c:IsAttribute(ATTRIBUTE_DEVINE) or c:IsRace(RACE_DEVINE) or c:IsRace(RACE_CREATORGOD) 
		or bit.band(c:GetOriginalRace(),RACE_DEVINE)==RACE_DEVINE or bit.band(c:GetOriginalRace(),RACE_CREATORGOD)==RACE_CREATORGOD 
		or bit.band(c:GetOriginalAttribute(),ATTRIBUTE_DEVINE)==ATTRIBUTE_DEVINE) and c:IsAbleToRemove()
end
function c511001887.filter2(c)
	return c:IsFacedown() and (c:IsAttribute(ATTRIBUTE_DEVINE) or c:IsRace(RACE_DEVINE) or c:IsRace(RACE_CREATORGOD) 
		or bit.band(c:GetOriginalRace(),RACE_DEVINE)==RACE_DEVINE or bit.band(c:GetOriginalRace(),RACE_CREATORGOD)==RACE_CREATORGOD 
		or bit.band(c:GetOriginalAttribute(),ATTRIBUTE_DEVINE)==ATTRIBUTE_DEVINE) and c:IsAbleToRemove()
end
function c511001887.banop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001887.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local conf=Duel.GetMatchingGroup(c511001887.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
		Duel.Remove(conf,POS_FACEUP,REASON_EFFECT)
	end
end
function c511001887.chkop(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE,POS_FACEDOWN)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
	end
end
