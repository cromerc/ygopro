--Spellbook of Miracles
function c804000088.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c804000088.cost)
	e1:SetTarget(c804000088.target)
	e1:SetOperation(c804000088.activate)
	c:RegisterEffect(e1)
end
function c804000088.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,804000088)==0 end
	Duel.RegisterFlagEffect(tp,804000088,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c804000088.filter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c804000088.filter2(c)
	return c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL)
end
function c804000088.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c804000088.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c804000088.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) 
		and Duel.IsExistingTarget(c804000088.filter2,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c804000088.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,c804000088.filter2,tp,LOCATION_REMOVED,0,2,2,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,1,0,0)
end
function c804000088.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsType,nil,TYPE_SPELL):Filter(Card.IsRelateToEffect,nil,e)
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.BreakEffect()
		if sg:GetCount()~=2 then return end
		Duel.Overlay(tc,sg)
	end
end
