--狂戦士の魂
function c100000199.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetRange(LOCATION_HAND+LOCATION_ONFIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c100000199.descon)
	e1:SetTarget(c100000199.target)
	e1:SetOperation(c100000199.spop)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c100000199.dacon)
	e2:SetCost(c100000199.cost)
	e2:SetTarget(c100000199.tar)
	e2:SetOperation(c100000199.acti)
	c:RegisterEffect(e2)
end
function c100000199.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetTurnPlayer()==e:GetHandler():GetControler()
end
function c100000199.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():GetAttack()<=1500 end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c100000199.spop(e,tp,c)
	local rc=Duel.GetAttacker()
	if rc:IsFaceup() then 	
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(100000199)
		e3:SetRange(LOCATION_MZONE)
		e3:SetTargetRange(LOCATION_MZONE,0)
		e3:SetLabelObject(rc)	
		e3:SetTarget(c100000199.tg)
		rc:RegisterEffect(e3)
	end
end
function c100000199.tg(e,c)
	return c==e:GetLabelObject()
end
function c100000199.dacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE	and Duel.GetTurnPlayer()==e:GetHandler():GetControler()
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
function c100000199.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsHasEffect,tp,LOCATION_MZONE,0,1,nil,100000199) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsHasEffect,tp,LOCATION_MZONE,0,1,1,nil,100000199)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c100000199.acti(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstTarget()
	while Duel.Draw(tp,1,REASON_EFFECT)~=0 and tg:IsFaceup() and tg:IsRelateToEffect(e) do
		local tc=Duel.GetOperatedGroup():GetFirst()
		Duel.ConfirmCards(tp,tc)		
		if tc:IsType(TYPE_MONSTER) then		
			if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 then	
				Duel.Damage(1-tp,tg:GetAttack(),REASON_EFFECT)
			end
		else return Duel.ShuffleHand(tp)end
	 end
end