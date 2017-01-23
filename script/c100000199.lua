--狂戦士の魂
function c100000199.initial_effect(c)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c100000199.condition)
	e2:SetCost(c100000199.cost)
	e2:SetTarget(c100000199.target)
	e2:SetOperation(c100000199.activate)
	c:RegisterEffect(e2)
end
function c100000199.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000199.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c100000199.filter(c)
	return c:IsDirectAttacked() and c:IsAttackBelow(1500)
end
function c100000199.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000199.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000199.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000199.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c100000199.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	while Duel.Draw(tp,1,REASON_EFFECT)~=0 and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) do
		local gc=Duel.GetOperatedGroup():GetFirst()
		Duel.ConfirmCards(tp,gc)
		if gc and gc:IsType(TYPE_MONSTER) then		
			if Duel.SendtoGrave(gc,REASON_EFFECT)~=0 then	
				Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
				if Duel.GetLP(1-tp)<=0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then
					return Duel.SetLP(tp,0)
				end
			end
		else return Duel.ShuffleHand(tp)end
	end
end
