--Parasite mind
--scripted by GameMaster(GM)
function c511005601.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511005601.condition)
	e1:SetTarget(c511005601.thtg)
	e1:SetOperation(c511005601.thop)
	c:RegisterEffect(e1)
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
end
function c511005601.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511005601.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (c:IsType(TYPE_CONTINUOUS) and c:IsFaceup())
end
function c511005601.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and c511005601.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511005601.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511005601.filter,tp,0,LOCATION_ONFIELD,0,1,nil)
end
function c511005601.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	e:GetHandler():CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000)
end