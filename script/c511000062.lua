--The Unchosen One
function c511000062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000062.condition)
	e1:SetTarget(c511000062.target)
	e1:SetOperation(c511000062.operation)
	c:RegisterEffect(e1)
end
function c511000062.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,2,nil)
end
function c511000062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetCurrentPhase()~=PHASE_MAIN2 
	and Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,2,nil) end
	local g1=Duel.SelectTarget(1-tp,Card.IsDestructable,1-tp,LOCATION_MZONE,0,1,1,nil)
	local g2=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,g1:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,1,0,0)
end
function c511000062.filter(c,tp,eg,ep,ev,re,r,rp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511000062.operation(e,tp,eg,ep,ev,re,r,rp)
	local ex1,dg=Duel.GetOperationInfo(0,CATEGORY_DESTROY)
	local dc=dg:GetFirst()
	if dc:IsRelateToEffect(e) and Duel.Destroy(dc,REASON_EFFECT) then
		if dc:IsCanBeSpecialSummoned(e,0,tp,false,false) and c511000062.filter(dc) then
			Duel.BreakEffect()
			Duel.SpecialSummon(dc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end