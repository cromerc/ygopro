--Graceful Dice (Anime)
function c511000541.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000541.target)
	e1:SetOperation(c511000541.activate)
	c:RegisterEffect(e1)
end
function c511000541.filter(c)
	return c:IsAttackBelow(500) and c:IsFaceup()
end
function c511000541.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000541.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000541.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local d=Duel.TossDice(tp,1)
	e:SetLabel(d)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000541.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511000541.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
