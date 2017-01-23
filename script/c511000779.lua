--Speed Spell - Tyrant Force
function c511000779.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000779.cost)
	e1:SetOperation(c511000779.activate)
	c:RegisterEffect(e1)
end
function c511000779.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return tc and tc:IsCanRemoveCounter(tp,0x91,7,REASON_COST) end	 
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,7,REASON_COST)	
end
function c511000779.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	Duel.RegisterEffect(e2,tp)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c511000779.damcon)
	e3:SetOperation(c511000779.damop)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c511000779.cfilter(c,tp)
	return c:GetPreviousControler()==1-tp and bit.band(c:GetReason(),0x41)==0x41
end
function c511000779.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000779.cfilter,1,nil,tp)
end
function c511000779.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c511000779.cfilter,nil,tp)
	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
end
