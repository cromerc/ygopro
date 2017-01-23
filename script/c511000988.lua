--Masahiro the Dark Clown
function c511000988.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000988,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetCountLimit(1)
	e1:SetTarget(c511000988.target)
	e1:SetOperation(c511000988.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e2)
end
c511000988.illegal=true
function c511000988.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsType(TYPE_FLIP) end
	if chk==0 then return c:GetFlagEffect(511000988)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local g=Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,0,1,1,nil,TYPE_FLIP)
end
function c511000988.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		c:CopyEffect(tc:GetCode(),RESET_CHAIN,1)
		Duel.ChangePosition(c,POS_FACEDOWN_ATTACK,0,POS_FACEDOWN_DEFENSE,0)
		Duel.ChangePosition(c,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
		c:RegisterFlagEffect(511000988,RESET_EVENT+0x1fe0000,0,1)
	end
end
