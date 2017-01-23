--Take a Chance
function c511002753.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002753.target)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	--take a chance
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511002753.tg)
	e2:SetOperation(c511002753.op)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c511002753.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	e:SetLabel(Duel.GetLP(tp))
end
function c511002753.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c511002753.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dc=Duel.TossDice(tp,1)
	if dc==6 then
		Duel.SetLP(tp,Duel.GetLP(tp)*5,REASON_EFFECT)
	else
		local lp=e:GetLabelObject():GetLabel()
		Duel.SetLP(tp,lp,REASON_EFFECT)
		e:GetLabelObject():SetLabel(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		c:RegisterEffect(e1)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e3:SetRange(LOCATION_SZONE)
		e3:SetCountLimit(1)
		e3:SetCondition(c511002753.damcon)
		e3:SetOperation(c511002753.damop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c511002753.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511002753.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511002753)
	Duel.Damage(tp,1000,REASON_EFFECT)
end
