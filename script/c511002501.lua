--グレート・モス
function c511002501.initial_effect(c)
	c:EnableReviveLimit()
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511002501.spcon)
	e2:SetOperation(c511002501.spop)
	c:RegisterEffect(e2)
end
function c511002501.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=4
end
function c511002501.rfilter(c)
	return c:IsCode(58192742) and c:GetEquipGroup():IsExists(c511002501.eqfilter,1,nil)
end
function c511002501.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c511002501.rfilter,1,nil)
end
function c511002501.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c511002501.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
