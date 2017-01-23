--Buried Soul Talisman
function c511000942.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000942.condition)
	e1:SetTarget(c511000942.target)
	e1:SetOperation(c511000942.activate)
	c:RegisterEffect(e1)
end
function c511000942.cfilter(c,tp,tid)
	return bit.band(c:GetReason(),0x21)==0x21 and c:GetTurnID()==tid
		and c:GetPreviousControler()==tp
end
function c511000942.condition(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	return Duel.IsExistingMatchingCard(c511000942.cfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,2,nil,tp,tid)
end
function c511000942.filter(c,e,tp)
	return c:IsLevelAbove(5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000942.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	local dg=Group.CreateGroup()
	local g=Duel.GetMatchingGroup(c511000942.cfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,tp,tid)
	local tc=g:GetFirst()
	while tc do
		dg:AddCard(tc:GetReasonCard())
		tc=g:GetNext()
	end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000942.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	if dg:IsExists(Card.IsDestructable,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000942.activate(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	local dg=Group.CreateGroup()
	local g=Duel.GetMatchingGroup(c511000942.cfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,tp,tid)
	local tc=g:GetFirst()
	while tc do
		dg:AddCard(tc:GetReasonCard())
		tc=g:GetNext()
	end
	dg=dg:Filter(Card.IsDestructable,nil)
	if dg:GetCount()>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sp=Duel.SelectMatchingCard(tp,c511000942.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if sp:GetCount()>0 then
		Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
	end
end
