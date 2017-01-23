--Chaos Hundred Universe
function c511001427.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001427.target)
	e1:SetOperation(c511001427.activate)
	c:RegisterEffect(e1)
end
function c511001427.filter(c,tp,tid)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return no and no>=101 and no<=107 and c:IsSetCard(0x1048) and c:IsReason(REASON_DESTROY) and c:GetTurnID()==tid 
		and c:GetPreviousControler()==tp
end
function c511001427.spfilter(c,e,tp)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return no and no>=101 and no<=107 and c:IsSetCard(0x1048) and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false)
end
function c511001427.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	local g=Duel.GetMatchingGroup(c511001427.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,tp,tid)
	local ct=g:GetCount()
	if chk==0 then return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>=ct 
		and g:IsExists(Card.IsCanBeSpecialSummoned,ct,nil,e,0,tp,false,false) 
		and Duel.IsExistingMatchingCard(c511001427.spfilter,tp,LOCATION_EXTRA,0,ct,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,ct,0,0)
end
function c511001427.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511001427.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,tp,Duel.GetTurnCount())
	local ct=g:GetCount()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<ct then return end
	if not Duel.IsExistingMatchingCard(c511001427.spfilter,tp,LOCATION_EXTRA,0,ct,nil,e,tp) then return end
	if not g:IsExists(Card.IsCanBeSpecialSummoned,ct,nil,e,0,tp,false,false) then return end
	if ct>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c511001427.spfilter,tp,LOCATION_EXTRA,0,ct,ct,nil,e,tp)
		local tc2=g2:GetFirst()
		while tc2 do
			Duel.SpecialSummonStep(tc2,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc2:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc2:RegisterEffect(e2)
			tc2=g2:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
