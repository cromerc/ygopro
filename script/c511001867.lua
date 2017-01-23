--Destiny Break
function c511001867.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c511001867.condition)
	e1:SetTarget(c511001867.target)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511001867.drcon)
	e2:SetTarget(c511001867.drtg)
	e2:SetOperation(c511001867.drop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetOperation(c511001867.desop)
	c:RegisterEffect(e3)
end
function c511001867.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511001867.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetAttacker() and c511001867.drcon(e,tp,eg,ep,ev,re,r,rp) then
		e:SetCategory(CATEGORY_DRAW)
		e:SetOperation(c511001867.drop)
		c511001867.drtg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c511001867.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511001867.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,tp,1)
end
function c511001867.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		Duel.BreakEffect()
		if tc:IsType(TYPE_MONSTER) then
			Duel.NegateAttack()
			Duel.ShuffleHand(tp)
			tc:RegisterFlagEffect(511001867,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		else
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end
function c511001867.filter(c,e,tp)
	return c:GetFlagEffect(511001867)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001867.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001867)
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)<=0 then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511001867.filter,tp,LOCATION_HAND,0,ft,ft,nil,e,tp)
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
end
