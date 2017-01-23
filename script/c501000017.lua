--伝説の白き龍
function c501000017.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--match kill
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATCH_KILL)
	e2:SetCondition(c501000017.condition)
	c:RegisterEffect(e2)
end
c501000017.illegal=true
function c501000017.spfilter(c)
	return c:IsRace(RACE_SPELLCASTER)
end
function c501000017.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetMaterial()
	return 
	g:IsExists(c501000017.spfilter,1,nil)		
end
