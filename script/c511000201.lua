--Illusion Destruction
function c511000201.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000201.target)
	e1:SetOperation(c511000201.activate)
	c:RegisterEffect(e1)
end
function c511000201.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c511000201.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000201.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c511000201.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000201.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511000201.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if tc:IsLocation(LOCATION_MZONE) then
			Duel.ChangePosition(tc,POS_FACEDOWN_ATTACK,0,POS_FACEDOWN_DEFENSE,0)
		else
			Duel.ChangePosition(tc,POS_FACEDOWN)
			Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
		end
	end
end
