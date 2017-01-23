--Booby Trap E
function c511001283.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001283.cost)
	e1:SetTarget(c511001283.target)
	e1:SetOperation(c511001283.activate)
	c:RegisterEffect(e1)
end
function c511001283.cfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsFacedown() and c:CheckActivateEffect(true,true,true)~=nil
		and c:GetCode()~=511001283
end
function c511001283.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001283.cfilter,tp,LOCATION_SZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c511001283.cfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabelObject(g:GetFirst())
end
function c511001283.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	local tc=e:GetLabelObject()
	if not tc then return end
	local te,eg,ep,ev,re,r,rp=tc:CheckActivateEffect(true,true,true)
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg and tg(e,tp,eg,ep,ev,re,r,rp,0) then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511001283.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	local code=te:GetHandler():GetOriginalCode()
	c:CopyEffect(code,RESET_EVENT+0x1fc0000,1)
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
