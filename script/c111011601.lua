--ディープ・スペース・クルーザー・ナイン
function c111011601.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c111011601.spcon)
	e1:SetOperation(c111011601.spop)
	c:RegisterEffect(e1)
end
function c111011601.spfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAbleToGraveAsCost()
end
function c111011601.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c111011601.spfilter,c:GetControler(),LOCATION_HAND,0,1,c)
end
function c111011601.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c111011601.spfilter,c:GetControler(),LOCATION_HAND,0,1,1,c)
	Duel.SendtoGrave(g,REASON_COST)
end
