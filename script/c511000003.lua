--Zero Sprite
function c511000003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetDescription(aux.Stringid(511000003,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000003.target)
	e1:SetOperation(c511000003.operation)
	c:RegisterEffect(e1)
	end
function c511000003.filter(c)
	return c:IsFaceup() 
end
function c511000003.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000003.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000003.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000003.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c511000003.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and c511000003.filter(tc) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(0)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_EXTRA_ATTACK)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
	end
end
