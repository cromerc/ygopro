--Turn Jump
function c511000091.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_START,TIMING_BATTLE_START)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511000091.condition)
	e1:SetOperation(c511000091.operation)
	c:RegisterEffect(e1)
end
function c511000091.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511000091.filter(c)
	return c:GetAttackedCount()>0
end
function c511000091.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then 
		Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,4)
		Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,4)
		Duel.SkipPhase(tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,2,2)
		Duel.SkipPhase(tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,2)
		Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END,3)
		Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,3)
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,3,3)
		Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,3)
	elseif Duel.GetTurnPlayer()~=tp then
		Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END,4)
		Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,4)
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,2,2)
		Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,2)
		Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,3)
		Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,3)
		Duel.SkipPhase(tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,3,3)
		Duel.SkipPhase(tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,3)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_PHASE+PHASE_END,6)
	Duel.RegisterEffect(e1,tp)
	local be=Effect.CreateEffect(e:GetHandler())
	be:SetType(EFFECT_TYPE_FIELD)
	be:SetCode(EFFECT_CANNOT_EP)
	be:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	be:SetTargetRange(1,1)
	be:SetReset(RESET_PHASE+PHASE_MAIN1,7)
	Duel.RegisterEffect(be,tp)
	local sg=Duel.GetMatchingGroup(c511000091.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if sg:GetCount()>0 then
		local tc=sg:GetFirst()
		while tc do
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,7)
			tc:RegisterEffect(e2)
			tc=sg:GetNext()
		end
	end
end
