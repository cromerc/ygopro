--デルタ・バリア
function c100000237.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100000237.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c100000237.condition)
	e2:SetCost(c100000237.cost)
	e2:SetOperation(c100000237.operation)
	c:RegisterEffect(e2)
end
function c100000237.filter(c,tp)
	return c:GetCode()==100000237 and c:GetActivateEffect():IsActivatable(tp)
end 
function c100000237.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c100000237.filter,tp,LOCATION_GRAVE,0,nil,tp)
	local dg2=Duel.GetMatchingGroup(c100000237.filter,tp,0,LOCATION_GRAVE,nil,1-tp)
	Duel.BreakEffect()
	 if ((dg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>1) or (dg2:GetCount()>0 and Duel.GetLocationCount(1-tp,LOCATION_SZONE)>1))
	 and Duel.SelectYesNo(tp,aux.Stringid(100000237,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		if dg:GetCount()>0 then
			local g=Duel.SelectMatchingCard(tp,c100000237.filter,tp,LOCATION_GRAVE,0,1,3,nil,tp)
			local tc=g:GetFirst()
			while tc do
				Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
				tc=g:GetNext()
			end
		end
		if dg2:GetCount()>0 then
			local g2=Duel.SelectMatchingCard(tp,c100000237.filter,tp,0,LOCATION_GRAVE,1,3,nil,1-tp)
			local tc2=g2:GetFirst()
			while tc do
				Duel.MoveToField(tc2,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
				tc2=g2:GetNext()
			end
		end
	end
end
function c100000237.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttacker():GetControler()==tp or Duel.GetAttackTarget():GetControler()==tp)
	 and Duel.GetBattleDamage(tp)>0 and Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_ONFIELD,0,nil,100000237):GetCount()>2
end
function c100000237.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,100000237)==0 end
	Duel.RegisterFlagEffect(tp,100000237,RESET_PHASE+PHASE_END,0,1)
end
function c100000237.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end