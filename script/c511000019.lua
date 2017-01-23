--Shield Recovery
function c511000019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000019,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000019.target)
	e1:SetOperation(c511000019.activate)
	c:RegisterEffect(e1)
end
function c511000019.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x15) and c:IsCanAddCounter(0x1f,3)
end
function c511000019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000019.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000019.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000019.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x1f)
end
function c511000019.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsSetCard(0x15) and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1f,3)
	end
end
