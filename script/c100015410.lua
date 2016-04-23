--
function c100015410.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)	
	e1:SetCondition(c100015410.con)
	e1:SetCost(c100015410.cost)
	e1:SetOperation(c100015410.operation)
	c:RegisterEffect(e1)
end
function c100015410.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()	
	if chk==0 then return true end
	if tc and tc:IsAbleToRemoveAsCost() then 
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_COST) 
	else 
	return false 
	end
end
function c100015410.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x400) and c:IsSetCard(0x45) 
end
function c100015410.con(e,tp,eg,ep,ev,re,r,rp,chk)
	return tp~=ep and Duel.IsChainNegatable(ev) 
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c100015410.operation(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g1=nil
	local g2=nil	
	local t={}
	local p=1
	t[p]=aux.Stringid(100015410,0) p=p+1
	if Duel.GetTurnPlayer()~=tp then t[p]=aux.Stringid(100015410,1) p=p+1 end 
	if Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) then t[p]=aux.Stringid(100015410,2) p=p+1 end
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(100015410,3))
	local sel=Duel.SelectOption(1-tp,table.unpack(t))+1
	local opt=t[sel]-aux.Stringid(100015410,0)
	if opt==0 then 
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
		end
	elseif opt==1 then 
		Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
		Duel.SkipPhase(1-tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
		Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
		Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_BP)
		e1:SetTargetRange(0,1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	else	
		g1=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local des=g1:Select(tp,1,1,nil)
		Duel.SendtoHand(des,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,des)
	end	
end