--Aria from Beyond
function c511000146.initial_effect(c)
	--copy spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0x1e1,0x1e1)
	e1:SetTarget(c511000146.target)
	e1:SetOperation(c511000146.operation)
	c:RegisterEffect(e1)
end
function c511000146.filter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:GetType()==0x2 and not c:IsCode(511000146) and c:CheckActivateEffect(false,true,false)~=nil
end
function c511000146.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,1,true)
	end
	if chk==0 then return Duel.IsExistingTarget(c511000146.filter,tp,LOCATION_REMOVED,0,1,nil) end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000146,0))
	local g=Duel.SelectTarget(tp,c511000146.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	local te,eg,ep,ev,re,r,rp=g:GetFirst():CheckActivateEffect(false,true,true)
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	g:GetFirst():CreateEffectRelation(e)
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511000146.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te:GetHandler():IsRelateToEffect(e) then return end
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end