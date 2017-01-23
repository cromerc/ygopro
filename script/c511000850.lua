--Synchro Baton
function c511000850.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000850.target)
	e1:SetOperation(c511000850.activate)
	c:RegisterEffect(e1)
end
function c511000850.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000850.filter2(c,lv)
	return c:GetLevel()==lv and c:IsAbleToRemove()
end
function c511000850.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SYNCHRO)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511000850.filter,tp,LOCATION_MZONE,0,1,nil) and ct>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000850.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000850.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SYNCHRO)*600
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(ct)
		tc:RegisterEffect(e1)
	end
end
