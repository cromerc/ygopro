--Orichalcos Gigas
function c170000171.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCost(c170000171.cost)
	e1:SetTarget(c170000171.target)
	e1:SetOperation(c170000171.operation)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetValue(c170000171.val)
    e3:SetLabelObject(e1)
    c:RegisterEffect(e3)
end
function c170000171.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCode(EFFECT_SKIP_DP)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c170000171.skipcon)
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e1,tp)
end
function c170000171.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c170000171.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c170000171.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end	
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		e:SetLabel(e:GetLabel()+1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c170000171.val(e,c)
	return e:GetLabelObject():GetLabel()*500
end
