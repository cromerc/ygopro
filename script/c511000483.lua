--Soul Union
function c511000483.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000483.target)
	e1:SetOperation(c511000483.activate)
	c:RegisterEffect(e1)
end
function c511000483.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c511000483.cfilter(c)
	return c:IsSetCard(0x3008)
end
function c511000483.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000483.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000483.filter,tp,LOCATION_MZONE,0,1,nil) 
	and Duel.IsExistingTarget(c511000483.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511000483.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,c511000483.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g2:GetFirst():GetAttack()
	if atk<0 then atk=0 end
	e:SetLabel(atk)
end
function c511000483.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end
