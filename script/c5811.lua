--誤封の契約書
function c5811.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c5811.target)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(5811,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetCost(c5811.regcost)
	e2:SetOperation(c5811.regop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(5811,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c5811.damcon)
	e3:SetCost(c5811.damcost)
	e3:SetTarget(c5811.damtg)
	e3:SetOperation(c5811.damop)
	c:RegisterEffect(e3)
end
function c5811.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b2=Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY
	if Duel.SelectYesNo(tp,aux.Stringid(5811,2)) then
		local op=0
		if b2 then op=Duel.SelectOption(tp,aux.Stringid(5811,0),aux.Stringid(5811,1))
		else op=Duel.SelectOption(tp,aux.Stringid(5811,0)) end
		if op==0 then
			e:GetHandler():RegisterFlagEffect(5811,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(5811,3))
			e:SetOperation(c5811.regop)
		else
			e:GetHandler():RegisterFlagEffect(6811,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(5811,4))
			Duel.SetTargetPlayer(tp)
			Duel.SetTargetParam(1000)
			Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
			e:SetOperation(c5811.damop)
		end
	else
		e:SetOperation(0)
	end
end
function c5811.regcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(5811)==0 end
	e:GetHandler():RegisterFlagEffect(5811,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c5811.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local fid=c:GetFieldID()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c5811.distarget)
	e1:SetLabel(fid)
	e1:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e1,tp)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c5811.disop)
	e2:SetLabel(fid)
	e2:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e2,tp)
	--disable trap monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c5811.distarget)
	e3:SetLabel(fid)
	e3:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e3,tp)
end
function c5811.distarget(e,c)
	return c:GetFieldID()~=e:GetLabel() and c:IsType(TYPE_TRAP) and c:IsStatus(STATUS_ACTIVATED)
end
function c5811.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) and re:GetHandler():GetFieldID()~=e:GetLabel() then
		Duel.NegateEffect(ev)
	end
end
function c5811.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c5811.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(6811)==0 end
	e:GetHandler():RegisterFlagEffect(6811,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c5811.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c5811.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
