--Counter Force
function c511000403.initial_effect(c)
	c:EnableCounterPermit(0x99)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511000403.ctop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000403,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_STANDBY_PHASE)
	e3:SetCondition(c511000403.damcon)
	e3:SetCost(c511000403.damcost)
	e3:SetTarget(c511000403.damtg)
	e3:SetOperation(c511000403.damop)
	c:RegisterEffect(e3)
end
function c511000403.ctop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_PLAYER)
	local c=e:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_COUNTER) then
		c:AddCounter(0x99,1)
	end
end
function c511000403.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()==tp
end
function c511000403.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	local ct=e:GetHandler():GetCounter(0x99)
	e:SetLabel(ct)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511000403.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetCounter(0x99)>0 end
	local dam=e:GetLabel()*1000
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511000403.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end