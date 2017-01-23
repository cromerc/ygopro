--Overlay Connection
function c511001167.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001167.target)
	e1:SetOperation(c511001167.activate)
	c:RegisterEffect(e1)
end
function c511001167.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()==0
end
function c511001167.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001167.filter(chkc) end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.IsExistingTarget(c511001167.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001167.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001167.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetCondition(c511001167.con)
		e1:SetOperation(c511001167.op)
		e1:SetReset(RESET_EVENT+0x1fa0000)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	end
end
function c511001167.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and bit.band(c:GetPreviousLocation(),LOCATION_OVERLAY)~=0
end
function c511001167.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc==nil then return end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001167,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCost(c511001167.atcost)
	e1:SetCondition(c511001167.atcon)
	e1:SetOperation(c511001167.atop)
	e1:SetLabelObject(tc)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511001167.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511001167.atcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tp==Duel.GetTurnPlayer() and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup()
end
function c511001167.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc:IsFaceup() and tc:IsLocation(LOCATION_MZONE) and c:IsRelateToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetCondition(c511001167.con)
		e1:SetOperation(c511001167.op)
		e1:SetReset(RESET_EVENT+0x1fa0000)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	end
end
