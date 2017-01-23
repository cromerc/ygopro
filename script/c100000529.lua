--ワルキューレの抱擁
function c100000529.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000529.target)
	e1:SetOperation(c100000529.activate)
	c:RegisterEffect(e1)
end
function c100000529.filter(c)
	local code=c:GetCode()
	return c:IsFaceup() and (code==100000533 or code==100000534 or code==100000537 or code==100000538) 
end
function c100000529.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c100000529.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g1=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g1,1,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g2,1,0,0)
end
function c100000529.activate(e,tp,eg,ep,ev,re,r,rp)
	local ex1,tg1=Duel.GetOperationInfo(0,CATEGORY_POSITION)
	local ex2,tg2=Duel.GetOperationInfo(0,CATEGORY_REMOVE)
	if tg1:GetFirst() and tg1:GetFirst():IsRelateToEffect(e) then
		Duel.ChangePosition(tg1,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
	if tg2:GetFirst() and tg2:GetFirst():IsRelateToEffect(e) then
		Duel.Remove(tg2,POS_FACEUP,REASON_EFFECT)
	end
end
