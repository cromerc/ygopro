--Jackie Jumper
function c511000742.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000742.spcon)
	e1:SetOperation(c511000742.spop)
	c:RegisterEffect(e1)
end
function c511000742.spfilter(c)
	return c:IsSetCard(0x43) and c:IsAbleToGraveAsCost()
end
function c511000742.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000742.spfilter,tp,LOCATION_HAND,0,1,c)
end
function c511000742.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000742.spfilter,tp,LOCATION_HAND,0,1,99,c)
	Duel.SendtoGrave(g,REASON_COST)
end
