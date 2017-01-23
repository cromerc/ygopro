--Holy Sacrifice
function c511001512.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001512.target)
	e1:SetOperation(c511001512.activate)
	c:RegisterEffect(e1)
end
function c511001512.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001512.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		e1:SetCountLimit(1)
		e1:SetLabel(0)
		e1:SetLabelObject(tc)
		e1:SetOperation(c511001512.desop)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetOperation(c511001512.ndop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetLabelObject(e1)
		Duel.RegisterEffect(e2,tp)
		tc:CreateEffectRelation(e1)
	end
end
function c511001512.ndop(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ep~=tp or ph<0x08 or ph>0x20 then return end
	local sum=e:GetLabelObject():GetLabel()+ev
	Duel.ChangeBattleDamage(tp,0)
	e:GetLabelObject():SetLabel(sum)
end
function c511001512.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local val=e:GetLabel()
	if tc:IsRelateToEffect(e) and tc:GetAttack()<val then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
