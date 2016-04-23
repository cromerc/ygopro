--Synchro Monument
function c511000039.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Synchro Monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000039,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000039.syncon)
	e2:SetOperation(c511000039.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c511000039.tuncon)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EVENT_CHAIN_END)
	e6:SetOperation(c511000039.op2)
	c:RegisterEffect(e6)
end
function c511000039.syncon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c511000039.tuncon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsType(TYPE_TUNER)
end
function c511000039.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then
		Duel.SetChainLimitTillChainEnd(c511000039.chainlm)
	else
		e:GetHandler():RegisterFlagEffect(511000039,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511000039.op2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(c511000039)~=0 then
		Duel.SetChainLimitTillChainEnd(c511000039.chainlm)
	end
	e:GetHandler():ResetFlagEffect(511000039)
end
function c511000039.chainlm(e,rp,tp)
	return tp==rp
end