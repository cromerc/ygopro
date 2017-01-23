--Reverse of Reverse
function c511000211.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCondition(c511000211.condition)
	e1:SetTarget(c511000211.target)
	e1:SetOperation(c511000211.activate)
	c:RegisterEffect(e1)
end
function c511000211.condition(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0xc,0)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 and ct==1
end
function c511000211.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511000211.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000211.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,c) end
	local sg=Duel.GetMatchingGroup(c511000211.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,c)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,sg,sg:GetCount(),0,0)
end
function c511000211.activate(e,tp,eg,ep,ev,re,r,rp)
	local gh=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND,nil)
	if gh:GetCount()>0 then
		Duel.ConfirmCards(tp,gh)
	end
	local gf=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_SZONE,nil)
	if gf:GetCount()>0 then
		Duel.ConfirmCards(tp,gf)
	end
	local sg=Duel.GetMatchingGroup(c511000211.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,c)
	if sg==0 then return end
	local g=Duel.SelectMatchingCard(tp,c511000211.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,sg:GetCount(),nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
		e1:SetTargetRange(LOCATION_HAND,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		--Trap activate in set turn
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e2:SetTargetRange(LOCATION_SZONE,0)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
		if gh:GetCount()>0 then
			Duel.ShuffleHand(1-tp)
		end
	end
end
