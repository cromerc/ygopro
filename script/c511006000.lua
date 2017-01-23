--Eternal Spell
function c511006000.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511006000.thtg)
	e1:SetOperation(c511006000.thop)
	c:RegisterEffect(e1)
end
function c511006000.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS)
end
function c511006000.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511006000.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511006000.filter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511006000.filter,tp,0,LOCATION_GRAVE,1,1,nil)
end
function c511006000.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	e:GetHandler():CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000)
end