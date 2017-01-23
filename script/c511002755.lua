--ハイパー・シンクロン
function c511002755.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40348946,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c511002755.con)
	e1:SetOperation(c511002755.op)
	c:RegisterEffect(e1)
end
function c511002755.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO and c:GetReasonCard():IsRace(RACE_DRAGON)
end
function c511002755.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(800)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	sync:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	sync:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetOperation(c511002755.rmop)
	e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	e3:SetLabel(0)
	sync:RegisterEffect(e3)
end
function c511002755.rmop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=e:GetLabel()
	e:GetHandler():SetTurnCounter(ct+1)
	if ct==1 then
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	else e:SetLabel(1) end
end
