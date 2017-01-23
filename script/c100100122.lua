--Ｓｐ－オーバー・ブースト
function c100100122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100122.condition)
	e1:SetTarget(c100100122.target)
	e1:SetOperation(c100100122.activate)
	c:RegisterEffect(e1)
end
function c100100122.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)<7 and not Duel.IsPlayerAffectedByEffect(tp,100100090)
end
function c100100122.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
end
function c100100122.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local tc=Duel.GetFieldCard(p,LOCATION_SZONE,5)
	if not tc or Duel.IsPlayerAffectedByEffect(p,100100090) then return end
	if tc:GetCounter(0x91)<7 then
		tc:AddCounter(0x91,6)
	else
		tc:AddCounter(0x91,12-tc:GetCounter(0x91))
	end
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetOperation(c100100122.op)
	e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	tc:RegisterEffect(e3)
end
function c100100122.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if tc:GetCounter(0x91)<=1 then return end
	if tc:GetCounter(0x91)>1 then 
		tc:RemoveCounter(tp,0x91,tc:GetCounter(0x91)-1,REASON_EFFECT)	
	end
end
