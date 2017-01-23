--ダークネス・シード
function c100000700.initial_effect(c)
	--trigger
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c100000700.regcon)
	e1:SetOperation(c100000700.regop)
	c:RegisterEffect(e1)
	--lp4000
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c100000700.con)
	e2:SetTarget(c100000700.lptg)
	e2:SetOperation(c100000700.lpop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetCondition(c100000700.con)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c100000700.regcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c100000700.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCountLimit(1)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCondition(c100000700.spcon)
		e1:SetOperation(c100000700.spop)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,3)
			e1:SetLabel(-1)
		else
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
			e1:SetLabel(0)
		end
		c:RegisterEffect(e1)
		c:CreateEffectRelation(e1)
	end
end
function c100000700.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000700.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	if ct<1 then
		ct=ct+1
		e:SetLabel(ct)
		return
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) then
		c:RegisterFlagEffect(100000700,RESET_EVENT+0x1ff0000,0,0)
	end
end
function c100000700.con(e)
	return e:GetHandler():GetFlagEffect(100000700)>0
end
function c100000700.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)<4000 end
	Duel.SetTargetPlayer(tp)
end
function c100000700.lpop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.SetLP(p,4000)
end
