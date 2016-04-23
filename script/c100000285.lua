--結束の翼
function c100000285.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000285.condition)
	e1:SetTarget(c100000285.target)
	e1:SetOperation(c100000285.activate)
	c:RegisterEffect(e1)
end
function c100000285.cfilter(c) 
	return c:IsFaceup() and c:IsCode(80208158)
end
function c100000285.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(c100000285.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000285.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c100000285.spfilter(c,e,tp)
	return c:IsCode(43791861) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000285.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.NegateAttack()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100000285.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()~=0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
