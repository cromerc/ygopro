--ダーク・グレファー
function c511009099.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14536035,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511009099.spcon)
	e1:SetOperation(c511009099.spop)
	c:RegisterEffect(e1)
end
function c511009099.spfilter(c)
	return c:IsRace(RACE_WARRIOR)
end
function c511009099.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c511009099.spfilter,c:GetControler(),LOCATION_HAND,0,1,c)
end
function c511009099.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c511009099.spfilter,tp,LOCATION_HAND,0,1,1,c)
	Duel.SendtoGrave(g,REASON_DISCARD+REASON_COST)
end