--The Unchosen One (Anime)
function c513000019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000019.condition)
	e1:SetTarget(c513000019.target)
	e1:SetOperation(c513000019.operation)
	c:RegisterEffect(e1)
end
function c513000019.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=2
end
function c513000019.filter(c,tp)
	return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,c)
end
function c513000019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c513000019.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c513000019.filter,1-tp,LOCATION_MZONE,0,1,nil,tp) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local g=Duel.SelectTarget(1-tp,c513000019.filter,1-tp,LOCATION_MZONE,0,1,1,nil,tp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,g:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c513000019.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,tc)
		if Duel.Destroy(sg,REASON_EFFECT)>0 then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
			if sg:IsExists(Card.IsCanBeSpecialSummoned,1,nil,e,0,tp,false,false) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local g=sg:FilterSelect(tp,Card.IsCanBeSpecialSummoned,1,1,nil,e,0,tp,false,false)
				Duel.BreakEffect()
				Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			end
		end
	end
end
