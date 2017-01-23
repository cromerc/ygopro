--Kung Fu Nyan Nyan
--scripted by: UnknownGuest
function c810000091.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c810000091.checkop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetLabelObject(e1)
	e2:SetOperation(c810000091.clear)
	c:RegisterEffect(e2)
	--ATK Up
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCondition(c810000091.reccon)
	e3:SetOperation(c810000091.recop)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
end
function c810000091.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetAttackedCount()==0 and Duel.GetTurnPlayer()==tp then
		e:SetLabel(1)
	end
end
function c810000091.clear(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()==1 and Duel.GetTurnPlayer()==tp then
		e:GetLabelObject():SetLabel(0)
	end
end
function c810000091.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return tp==Duel.GetTurnPlayer() and c:IsPosition(POS_FACEUP_ATTACK) and e:GetLabelObject():GetLabel()==1
end
function c810000091.recop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(300)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(810000091,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c810000091.adcon)
	e2:SetOperation(c810000091.adop)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
end
function c810000091.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-300)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c810000091.adcon(e)
	return e:GetHandler():GetAttackedCount()>0
end
