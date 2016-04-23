--Scripted by Eerie Code
--Clash of the Dracorivals
function c6861.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e1:SetCountLimit(1,6861+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c6861.target)
	e1:SetOperation(c6861.activate)
	c:RegisterEffect(e1)
end

function c6861.pzfilter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7)
end
function c6861.sfilter(c,e,tp,sc)
	return c:IsSetCard(sc) and ((c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0) or Duel.GetMatchingGroupCount(c6861.pzfilter,tp,LOCATION_SZONE,0,nil)<2)
end
function c6861.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6861.sfilter,tp,LOCATION_DECK,0,1,nil,e,tp,0xc7) and Duel.IsExistingMatchingCard(c6861.sfilter,tp,LOCATION_DECK,0,1,nil,e,tp,0xd7) end
end
function c6861.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and Duel.GetMatchingGroupCount(c6861.pzfilter,tp,LOCATION_SZONE,0,nil)>=2 then return end
	local g1=Duel.SelectMatchingCard(tp,c6861.sfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,0xc7)
	if g1:GetCount()==0 then return end
	local g2=Duel.SelectMatchingCard(tp,c6861.sfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,0xd7)
	if g2:GetCount()==0 then return end
	local g=Group.FromCards(g1:GetFirst(),g2:GetFirst())
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleDeck(tp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONFIRM)
	local tg=g:Select(1-tp,1,1,nil)
	local tc=tg:GetFirst()
	Duel.ConfirmCards(tp,tc)
	local op
	g:RemoveCard(tc)
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE,0)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
	local b2=Duel.GetMatchingGroupCount(c6861.pzfilter,tp,LOCATION_SZONE,0,nil)<2
	if b1 and b2 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(6861,0))
		op=Duel.SelectOption(tp,aux.Stringid(6861,1),aux.Stringid(6861,2))
	elseif b1 then op=1 else op=0 end
	if op==1 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	else
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	Duel.SendToExtra(g,POS_FACEUP,REASON_EFFECT)
end