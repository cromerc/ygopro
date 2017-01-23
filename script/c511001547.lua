--Beast-borg Medal of the Iron Shield
function c511001547.initial_effect(c)
	c:EnableCounterPermit(0x103)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c511001547.ctcon)
	e2:SetOperation(c511001547.ctop)
	c:RegisterEffect(e2)
	--gain atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001547,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511001547.atkcost)
	e3:SetTarget(c511001547.atktg)
	e3:SetOperation(c511001547.atkop)
	c:RegisterEffect(e3)
end
function c511001547.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return ev>=100 and ep==tp
end
function c511001547.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ct=math.floor(ev/100)
	c:AddCounter(0x103,ct)
end
function c511001547.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetHandler():GetCounter(0x103)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and ct>0 end
	e:SetLabel(ct)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511001547.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x20c)
end
function c511001547.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001547.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001547.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001547.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001547.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(e:GetLabel()*100)
		tc:RegisterEffect(e1)
	end
end
