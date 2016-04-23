--Ｆａｉｒｙ Ｔａｌｅ 第二章 暴怒の太陽
function c100000331.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000331.con)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c100000331.rdop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCountLimit(1)
	e3:SetCondition(c100000331.condition)
	e3:SetTarget(c100000331.target)
	e3:SetOperation(c100000331.activate)
	c:RegisterEffect(e3)
end
function c100000331.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,100000330)==5
end
function c100000331.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev*2)
	Duel.ChangeBattleDamage(1-tp,ev*2)
end
function c100000331.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFlagEffect(tp,100000330)==0
end
function c100000331.filter(c)
	return c:GetCode()==100000332
end
function c100000331.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000331.filter,tp,0x13,0,1,nil,tp) end
end
function c100000331.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=nil
	local tg=Duel.GetMatchingGroup(c100000331.filter,tp,0x13,0,nil)
	if tg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100000331,0))
		tc=Duel.SelectMatchingCard(tp,c100000331.filter,tp,0x13,0,1,1,nil):GetFirst()
	else
		tc=tg:GetFirst()
	end	
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.RegisterFlagEffect(tp,100000330,RESET_PHASE+PHASE_END,0,1)
	Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
end
