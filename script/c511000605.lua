--Dormant Volcano
function c511000605.initial_effect(c)
	--Damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511000605.drcon)
	e1:SetTarget(c511000605.damtg)
	e1:SetOperation(c511000605.damop)
	c:RegisterEffect(e1)
end
function c511000605.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE)
end
function c511000605.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c511000605.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetOperation(c511000605.thop)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
		e1:SetCondition(c511000605.skipcon)
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e1,tp)
end
function c511000605.con(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c511000605.filter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToHand()
end
function c511000605.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local g1=nil
	local tc1=nil
	local g2=nil
	local tc2=nil
	if Duel.IsExistingMatchingCard(c511000605.filter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(511000605,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		g1=Duel.SelectMatchingCard(tp,c511000605.filter,tp,LOCATION_DECK,0,1,1,nil)
		tc1=g1:GetFirst()
	end
	if Duel.IsExistingMatchingCard(c511000605.filter,tp,0,LOCATION_DECK,1,nil) and Duel.SelectYesNo(1-tp,aux.Stringid(511000605,0)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		g2=Duel.SelectMatchingCard(1-tp,c511000605.filter,tp,0,LOCATION_DECK,1,1,nil)
		tc2=g2:GetFirst()
	end
	if g1 then Duel.SendtoHand(g1,nil,REASON_EFFECT) end
	if g2 then Duel.SendtoHand(g2,nil,REASON_EFFECT) end
	if tc1 then Duel.ConfirmCards(1-tp,tc1) end
	if tc2 then	Duel.ConfirmCards(tp,tc2) end
end
