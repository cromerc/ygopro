--Ｆａｉｒｙ Ｔａｌｅ最終章 忘却の妖月
function c100000333.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000333.con)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c100000333.sptg2)
	e2:SetOperation(c100000333.spop2)
	c:RegisterEffect(e2)	
	local e3=Effect.CreateEffect(c)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCountLimit(1)
	e3:SetCondition(c100000333.condition)
	e3:SetTarget(c100000333.target)
	e3:SetOperation(c100000333.activate)
	c:RegisterEffect(e3)
end
function c100000333.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,100000330)==5
end
function c100000333.pofilter1(c,e,tp)
	return c:GetPosition()==POS_FACEUP_ATTACK and c:GetPreviousPosition()>0x3
end
function c100000333.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return eg:IsContains(chkc) and c100000333.pofilter1(chkc) end
	if chk==0 then return eg:IsExists(c100000333.pofilter1,1,nil) end
	return true
end
function c100000333.spop2(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100000333.pofilter1,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	 tc=g:GetNext()
	end
end
function c100000333.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFlagEffect(tp,100000330)==0
end
function c100000333.filter(c)
	return c:GetCode()==100000330
end
function c100000333.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000333.filter,tp,0x13,0,1,nil,tp) end
end
function c100000333.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=nil
	local tg=Duel.GetMatchingGroup(c100000333.filter,tp,0x13,0,nil)
	if tg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100000333,0))
		tc=Duel.SelectMatchingCard(tp,c100000333.filter,tp,0x13,0,1,1,nil):GetFirst()
	--	if tc:IsLocation(LOCATION_DECK) then
	--	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_RULE)end
	--	if tc:IsLocation(LOCATION_HAND) then
	--	Duel.SendtoHand(e:GetHandler(),nil,1,REASON_RULE)end
	else
		tc=tg:GetFirst()
	end	
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.RegisterFlagEffect(tp,100000330,RESET_PHASE+PHASE_END,0,1)
	Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
end
