--Ｓｐ－ハーフ・シーズ
function c100100124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100124.con)
	e1:SetTarget(c100100124.target)
	e1:SetOperation(c100100124.operation)
	c:RegisterEffect(e1)
end
function c100100124.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc:GetCounter(0x91)>2
end
function c100100124.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	return true
end
function c100100124.operation(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsFaceup,e:GetHandler():GetControler(),0,LOCATION_MZONE,nil)		
	Duel.Hint(HINT_SELECTMSG,e:GetHandler():GetControler(),HINTMSG_FACEUP)
	local tc=dg:Select(e:GetHandler():GetControler(),1,1,nil)		
	Duel.Recover(tp,tc:GetFirst():GetAttack()/2,REASON_EFFECT)
end
