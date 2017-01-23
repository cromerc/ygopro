--Synchro Nova
function c511002802.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002802.target)
	e1:SetOperation(c511002802.activate)
	c:RegisterEffect(e1)
end
function c511002802.filter(c,e,tp,lv)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002802.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	if chk==0 then return g:GetCount()>0 and g:FilterCount(Card.IsAbleToRemove,nil)==g:GetCount() 
		and g:IsExists(Card.IsType,1,nil,TYPE_SYNCHRO) and g:IsExists(Card.IsType,1,nil,TYPE_TUNER) 
		and Duel.IsExistingMatchingCard(c511002802.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,g:GetCount()) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002802.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,nil)
	local ct=Duel.Remove(g,POP_FACEUP,REASON_EFFECT)
	if ct>0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c511002802.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,ct)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
