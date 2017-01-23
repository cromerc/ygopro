--Transistor the Warrior
function c511009098.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30190809,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511009098.condition)
	e1:SetCost(c511009098.cost)
	e1:SetOperation(c511009098.operation)
	c:RegisterEffect(e1)
end
function c511009098.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and e:GetHandler():GetEffectCount(EFFECT_DIRECT_ATTACK)==0
end
function c511009098.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c511009098.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end