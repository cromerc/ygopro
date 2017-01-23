--Surprise Attack from Beyond
function c511000180.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000180.activate)
	c:RegisterEffect(e1)
end
function c511000180.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c511000180.operation)
	Duel.RegisterEffect(e1,tp)
end
function c511000180.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000180.dfilter(c)
	return c:GetTurnID()==Duel.GetTurnCount() and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0
end
function c511000180.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511000180)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c511000180.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000180.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
		if g:GetCount()~=0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	if Duel.IsExistingTarget(c511000180.dfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) then
		local g=Duel.SelectMatchingCard(tp,c511000180.dfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		local d=tc:GetAttack()
		Duel.Damage(1-tp,d,REASON_BATTLE)
	end
end
