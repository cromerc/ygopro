--Xyz Stand
function c511002748.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002748.target)
	e1:SetOperation(c511002748.activate)
	c:RegisterEffect(e1)
end
function c511002748.filter(c,tid,e,tp)
	return c:IsReason(REASON_BATTLE) and c:IsType(TYPE_XYZ) and c:GetTurnID()==tid
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetPreviousControler()==tp
end
function c511002748.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511002748.filter,tp,LOCATION_GRAVE,0,nil,Duel.GetTurnCount(),e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()==1 end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002748.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002748.filter,tp,LOCATION_GRAVE,0,nil,Duel.GetTurnCount(),e,tp)
	local tc=g:GetFirst()
	if g:GetCount()~=1 or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if tc and tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		Duel.SpecialSummonComplete()
	end
end
