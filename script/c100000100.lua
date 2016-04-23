--パワー・ウォール
function c100000100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c100000100.condition)
	e1:SetOperation(c100000100.activate)
	c:RegisterEffect(e1)
end
function c100000100.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil and Duel.IsPlayerCanDiscardDeck(tp,1) 
end
function c100000100.activate(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local l=1
	while Duel.IsPlayerCanDraw(tp,l) do
		t[l]=l
		l=l+1
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100000100,0))
	local announce=Duel.AnnounceNumber(tp,table.unpack(t))	
	Duel.DiscardDeck(tp,announce,REASON_EFFECT)
	if Duel.GetBattleDamage(tp)>=announce*100 then
		Duel.ChangeBattleDamage(tp,Duel.GetBattleDamage(tp)-announce*100)
	else
		Duel.ChangeBattleDamage(tp,0)
	end
	e:GetHandler():SetHint(CHINT_NUMBER,announce)
	e:GetHandler():RegisterFlagEffect(100000100,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end