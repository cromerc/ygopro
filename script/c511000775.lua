--Blackwing - Delta Union
function c511000775.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000775.tg)
	e1:SetOperation(c511000775.op)
	c:RegisterEffect(e1)
end
function c511000775.spfilter(c,e,tp,tid)
	return c:IsSetCard(0x33) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetTurnID()==tid and c:IsReason(REASON_DESTROY)
		and Duel.IsExistingMatchingCard(c511000775.eqfilter,tp,LOCATION_GRAVE,0,1,c,tid)
end
function c511000775.eqfilter(c,tid)
	return c:IsSetCard(0x33) and c:IsType(TYPE_MONSTER) and c:GetTurnID()==tid and c:IsReason(REASON_DESTROY)
end
function c511000775.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingMatchingCard(c511000775.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tid) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511000775.op(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000775.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,tid)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local sg=Duel.GetMatchingGroup(c511000775.eqfilter,tp,LOCATION_GRAVE,0,nil,tid)
		if sg:GetCount()>Duel.GetLocationCount(tp,LOCATION_SZONE) then
			sg=sg:Select(tp,Duel.GetLocationCount(tp,LOCATION_SZONE),Duel.GetLocationCount(tp,LOCATION_SZONE),nil)
		end
		local eqtc=sg:GetFirst()
		while eqtc do
			if not Duel.Equip(tp,eqtc,g:GetFirst(),false) then return end
			local e1=Effect.CreateEffect(g:GetFirst())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511000775.eqlimit)
			eqtc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(g:GetFirst())
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(500)
			eqtc:RegisterEffect(e2)
			eqtc=sg:GetNext()
		end
	end
end
function c511000775.eqlimit(e,c)
	return e:GetOwner()==c
end
