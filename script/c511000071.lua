--Terminal Countdown
function c511000071.initial_effect(c)
	--Cannot Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetOperation(c511000071.op)
	c:RegisterEffect(e1)
	--Set Card
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000071,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000071.setcon)
	e2:SetTarget(c511000071.settg)
	e2:SetOperation(c511000071.setop)
	c:RegisterEffect(e2)
	--Damage LP
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000071,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000071.damcon)
	--e3:SetTarget(c511000071.damtg)
	e3:SetOperation(c511000071.damop)
	c:RegisterEffect(e3)
end
function c511000071.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c511000071.aclimit)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e1)
end
function c511000071.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511000071.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511000071.filter(c)
	return (c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL)) and c:IsSSetable()
end
function c511000071.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c511000071.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c511000071.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c511000071.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,tc)
		Duel.SSet(tp,g:GetFirst())
		c:SetCardTarget(tc)
	end
end
function c511000071.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tn=Duel.GetTurnPlayer()
	local ph=Duel.GetCurrentPhase()
	return (tn==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2))
end
function c511000071.damfilter(c,rc)
	return rc:GetCardTarget():IsContains(c)
end
function c511000071.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(c511000071.damfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil,c)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() 
	and Duel.IsExistingTarget(c511000071.damfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,e,tp) 
	and dg:IsAbleToGraveAsCost() end
end
function c511000071.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()>0 then
		local dg=Duel.GetMatchingGroup(c511000071.damfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil,c)
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
		local ct=Duel.SendtoGrave(dg,REASON_EFFECT)
		if ct==1 then
			Duel.Damage(1-tp,500,REASON_EFFECT)
		end	
		if ct==2 then
			Duel.Damage(1-tp,1500,REASON_EFFECT)
		end	
		if ct==3 then
			Duel.Damage(1-tp,3000,REASON_EFFECT)
		end
		if ct==4 then
			Duel.Damage(1-tp,6000,REASON_EFFECT)
		end
	end
end
