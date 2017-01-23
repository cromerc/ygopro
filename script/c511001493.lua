--Shining Reborn
function c511001493.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001493.cost)
	e1:SetTarget(c511001493.target)
	e1:SetOperation(c511001493.operation)
	c:RegisterEffect(e1)
end
function c511001493.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local sg=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(sg,REASON_COST)
end
function c511001493.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c511001493.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511001493.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_GRAVE)
end
function c511001493.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if Duel.SendtoGrave(g,REASON_EFFECT)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=Duel.SelectMatchingCard(tp,c511001493.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
		if sp:GetCount()>0 and Duel.SpecialSummon(sp,0,tp,1-tp,false,false,POS_FACEUP)>0 then
			local setg=Duel.GetMatchingGroup(Card.IsSSetable,1-tp,0,LOCATION_HAND,nil)
			if setg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(60082869,0)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
				local sg=setg:Select(tp,1,1,nil)
				Duel.SSet(1-tp,sg:GetFirst())
			end
		end
	end
end
