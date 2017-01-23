--選ばれし者
function c513000116.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c513000116.target)
	e1:SetOperation(c513000116.activate)
	c:RegisterEffect(e1)
end
function c513000116.spfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c513000116.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,2,e:GetHandler(),TYPE_SPELL+TYPE_TRAP)
		and Duel.IsExistingMatchingCard(c513000116.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
end
function c513000116.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g1=Duel.GetMatchingGroup(c513000116.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_SPELL+TYPE_TRAP)
	if g1:GetCount()==0 or g2:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(21888494,0))
	local sg1=g1:Select(tp,1,1,nil)
	local sc=sg1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(21888494,1))
	local sg2=g2:Select(tp,2,2,nil)
	sg1:Merge(sg2)
	Duel.ConfirmCards(1-tp,sg1)
	Duel.ShuffleHand(tp)
	local rg=sg1:Select(1-tp,1,1,nil)
	local tc=rg:GetFirst()
	if tc:IsType(TYPE_MONSTER) and tc:IsCanBeSpecialSummoned(e,0,tp,true,false) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		Duel.SendtoGrave(sg2,REASON_EFFECT)
	else
		Duel.SendtoGrave(sg1,REASON_EFFECT)
	end
end
