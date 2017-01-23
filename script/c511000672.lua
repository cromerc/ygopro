--Fire Whip
function c511000672.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000672.target)
	e1:SetOperation(c511000672.activate)
	c:RegisterEffect(e1)
end
function c511000672.filter(c,e,tp,tid)
	return c:IsReason(REASON_DESTROY) and c:GetTurnID()==tid
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000672.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(c511000672.filter,tp,0x73,0x73,nil,e,tp,Duel.GetTurnCount())
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>g:GetCount()-1
		and Duel.IsExistingMatchingCard(c511000672.filter,tp,0x73,0x73,1,nil,e,tp,Duel.GetTurnCount()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c511000672.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000672.filter,tp,0x73,0x73,nil,e,tp,Duel.GetTurnCount())
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<=g:GetCount()-1 then return end
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(ATTRIBUTE_FIRE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
