--Ｓｐ－オーバー・ブースト
function c100100122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100122.condition)
	e1:SetOperation(c100100122.activate)
	c:RegisterEffect(e1)
end
function c100100122.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc:GetCounter(0x91)<7
end
function c100100122.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	tc:RegisterFlagEffect(100100103,RESET_EVENT+RESET_CHAIN,0,1)
	tc:AddCounter(0x91,6)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetOperation(c100100122.desop)
	e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	tc:RegisterEffect(e3)
end
function c100100122.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if tc:GetCounter(0x91)==1 then return end
	if tc:GetCounter(0x91)>1 then 
		tc:RemoveCounter(tp,0x91,tc:GetCounter(0x91)-1,REASON_RULE)	
	else	
		tc:RegisterFlagEffect(100100103,RESET_EVENT+RESET_CHAIN,0,1)
		tc:AddCounter(0x91,1)
	end
end
