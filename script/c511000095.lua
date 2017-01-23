--Break Tune
function c511000095.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000095.condition)
	e1:SetTarget(c511000095.target)
	e1:SetOperation(c511000095.activate)
	c:RegisterEffect(e1)
end
function c511000095.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and Duel.IsExistingMatchingCard(c511000095.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
end
function c511000095.filter(c,e,tp)
	return c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000095.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511000095.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000095.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000095.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
			Duel.NegateAttack()
		end
	end
end