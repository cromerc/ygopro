--Magical Trick Mirror
function c23696988.initial_effect(c)
	--copy Spell
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(aux.Stringid(23696988,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c23696988.condition)
	e1:SetTarget(c23696988.target)
	e1:SetOperation(c23696988.operation)
	c:RegisterEffect(e1)
end
function c23696988.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c23696988.filter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil and not c:IsType(TYPE_FIELD)
end
function c23696988.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_GRAVE) or chkc:IsLocation(LOCATION_MZONE) and chkc:GetControler()~=tp and c23696988.filter(chkc) end
if chk==0 then return Duel.IsExistingTarget(c23696988.filter,tp,0,LOCATION_GRAVE,1,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
local g=Duel.SelectTarget(tp,c23696988.filter,tp,0,LOCATION_GRAVE,1,1,nil)
end
function c23696988.operation(e,tp,eg,ep,ev,re,r,rp)
 local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if c:IsRelateToEffect(e) and not tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
	local tpe=tc:GetType()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetValue(tpe)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e1)
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end 
	end
	if c:IsRelateToEffect(e) and  tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
	local tpe=tc:GetType()
	local code=tc:GetOriginalCode()
	c:CopyEffect(code,nil,1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetValue(tpe)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e1)
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end 
	c:CancelToGrave()
	end
end