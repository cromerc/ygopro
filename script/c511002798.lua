--Chaos Rising
function c511002798.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002798.condition)
	e1:SetTarget(c511002798.target)
	e1:SetOperation(c511002798.activate)
	c:RegisterEffect(e1)
end
function c511002798.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return ep==tp and ev>=2000 and (a:IsSetCard(0x1048) or (d and d:IsSetCard(0x1048)))
end
function c511002798.spfilter(c,e,tp)
	return c:IsSetCard(0x1048) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002798.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002798.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511002798.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002798.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
