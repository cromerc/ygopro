--Master and Servant's Resolve
function c511000948.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000948,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000948.damcon)
	e2:SetTarget(c511000948.damtg)
	e2:SetOperation(c511000948.damop)
	c:RegisterEffect(e2)
	--maintain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetOperation(c511000948.mtop)
	c:RegisterEffect(e3)
end
function c511000948.cfilter(c,re)
	return c:IsPreviousLocation(LOCATION_MZONE) and bit.band(c:GetReason(),0x41)==0x41 and re:IsActiveType(TYPE_EFFECT)
end
function c511000948.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	e:SetLabelObject(re)
	return eg:IsExists(c511000948.cfilter,1,nil,re) and 
		((Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) or (ph==PHASE_DAMAGE and not Duel.IsDamageCalculated()))
end
function c511000948.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c511000948.cfilter,nil,e:GetLabelObject())
	local tc=g:GetFirst()
	local chp=0
	while tc do
		if tc:GetControler()==tp and chp~=1 and chp~=3 then
			chp=chp+1
		elseif tc:GetControler()~=tp and chp~=2 and chp~=3 then
			chp=chp+2
		end
		tc=g:GetNext()
	end
	local p=0
	if chp==1 then
		p=tp
	elseif chp==2 then
		p=1-tp
	elseif chp==3 then
		p=PLAYER_ALL
	end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,nil,0)
end
function c511000948.cfilter2(c,tp,re)
	return c:IsPreviousLocation(LOCATION_MZONE) and bit.band(c:GetReason(),0x41)==0x41 
		and re:IsActiveType(TYPE_EFFECT) and c:GetPreviousControler()==tp
end
function c511000948.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=eg:Filter(c511000948.cfilter2,nil,tp,e:GetLabelObject())
	local g2=eg:Filter(c511000948.cfilter2,nil,1-tp,e:GetLabelObject())
	if g1:GetCount()>0 then
		local sum=g1:GetSum(Card.GetAttack)
		Duel.Damage(tp,sum,REASON_EFFECT)
	end
	if g2:GetCount()>0 then
		local sum=g2:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
function c511000948.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	if Duel.SelectYesNo(tp,aux.Stringid(511000948,1)) then
		Duel.Damage(tp,1000,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
