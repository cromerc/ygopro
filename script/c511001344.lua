--Retribution of the Ant Lion
function c511001344.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c511001344.regcon)
	e2:SetOperation(c511001344.regop)
	c:RegisterEffect(e2)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001344,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(511001344)
	e2:SetTarget(c511001344.damtg)
	e2:SetOperation(c511001344.damop)
	c:RegisterEffect(e2)
end
function c511001344.regcon(e,tp,eg,ep,ev,re,r,rp)
	local d1=false
	local d2=false
	local tc=eg:GetFirst()
	while tc do
		if tc:IsPreviousLocation(LOCATION_MZONE) and tc:IsType(TYPE_MONSTER) and tc:IsReason(REASON_DESTROY) then
			if tc:GetPreviousControler()==0 then d1=true
			else d2=true end
		end
		tc=eg:GetNext()
	end
	local evt_p=PLAYER_NONE
	if d1 and d2 then evt_p=PLAYER_ALL
	elseif d1 then evt_p=0
	elseif d2 then evt_p=1 end
	e:SetLabel(evt_p)
	return evt_p~=PLAYER_NONE
end
function c511001344.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),511001344,e,0,tp,e:GetLabel(),0)
end
function c511001344.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,ep,800)
end
function c511001344.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if ep==PLAYER_ALL then
		Duel.Damage(tp,d,REASON_EFFECT)
		Duel.Damage(1-tp,d,REASON_EFFECT)
	else
		Duel.Damage(ep,d,REASON_EFFECT)
	end
end
