--ライフ・フォース
function c100000117.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	c:RegisterEffect(e1)	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetTarget(c100000117.target2)
	e2:SetOperation(c100000117.operation)
	c:RegisterEffect(e2)
end
function c100000117.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,400) end
	Duel.PayLPCost(tp,400)
	if Duel.GetBattleDamage(tp)>0 then
		Duel.SetTargetPlayer(tp)
	else
		Duel.SetTargetPlayer(1-tp)
	end		
end
function c100000117.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetBattleDamage(tp)>0 then
		Duel.ChangeBattleDamage(tp,0)
	else
		Duel.ChangeBattleDamage(1-tp,0)
	end
end