--Utopian Hope
--scripted by:urielkama
function c511004121.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511004121.condition)
	e1:SetOperation(c511004121.activate)
	c:RegisterEffect(e1)
	--target reg
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BECOME_TARGET)
	e2:SetRange(0xff)
	e2:SetOperation(c511004121.regop1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetRange(0xff)
	e3:SetOperation(c511004121.regop2)
	c:RegisterEffect(e3)
	e3:SetLabelObject(e2)
end
function c511004121.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x7f))
	e1:SetValue(c511004121.ctfilter)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if e:GetHandler():GetFlagEffect(511004121)>0 then
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(0,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA)
	e1:SetTarget(c511000383.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	end
	local sg=Duel.GetMatchingGroup(Card.IsStatus,tp,0,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_DECK,nil,STATUS_ACTIVATED+STATUS_DISABLED)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
function c511004121.distarget(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_TRAP+TYPE_SPELL+TYPE_MONSTER)
end
function c511004121.regfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x7f)
end
function c511004121.regop1(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) or eg:GetCount()>0
		or not eg:IsExists(c511004121.regfilter,1,nil) then
		e:SetLabelObject(nil)
	else e:SetLabelObject(re) end
end
function c511004121.regop2(e,tp,eg,ep,ev,re,r,rp)
	local pe=e:GetLabelObject():GetLabelObject()
	if pe and pe==re then
		e:GetHandler():RegisterFlagEffect(511004121,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511004121.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,0x7f)
end
function c511004121.ctfilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_EFFECT) and e:GetOwnerPlayer()~=te:GetOwnerPlayer()
end