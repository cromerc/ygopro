--Revenge Sacrifice
function c511000215.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000215.condition)
	e1:SetTarget(c511000215.target)
	e1:SetOperation(c511000215.activate)
	c:RegisterEffect(e1)
end
function c511000215.filter(c,tp)
	return c:GetPreviousControler()==tp and c==Duel.GetAttackTarget()
end
function c511000215.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000215.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000215.filter,1,nil,tp)
end
function c511000215.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return chkc==at end
	if chk==0 then return at:IsControler(1-tp) and at:IsRelateToBattle() and at:IsCanBeEffectTarget(e)
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511000215.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetTargetCard(at)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000215.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetFirstTarget()
	if a:IsRelateToEffect(e) then
		if Duel.Release(a,REASON_COST)>0 then
			local g=Duel.SelectMatchingCard(tp,c511000215.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
			local tc=g:GetFirst()
			if tc then
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
