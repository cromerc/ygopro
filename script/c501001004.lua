---オッドアイズ・ペンデュラム・ドラゴン
function c501001004.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001004,0))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c501001004.rdcon)
	e2:SetOperation(c501001004.rdop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(501001004,1))
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c501001004.thcon)
	e3:SetCost(c501001004.thcos)
	e3:SetTarget(c501001004.thtg)
	e3:SetOperation(c501001004.thop)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c501001004.dcon)
	e4:SetOperation(c501001004.dop)
	c:RegisterEffect(e4)
end	
function c501001004.rdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	return (c:GetSequence()==6 or c:GetSequence()==7)
	and Duel.GetFlagEffect(tp,501001004+100000000)==0
	and ep==tp
	and (a:IsType(TYPE_PENDULUM) or (t~=nil and t:IsType(TYPE_PENDULUM)))
end
function c501001004.rdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if Duel.SelectEffectYesNo(tp,c) then
		Duel.ChangeBattleDamage(tp,0)
		Duel.RegisterFlagEffect(tp,501001004+100000000,RESET_PHASE+PHASE_END,0,1)
	end
end
function c501001004.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return (c:GetSequence()==6 or c:GetSequence()==7)
	and Duel.GetTurnPlayer()==tp
	and Duel.GetFlagEffect(tp,501001004+200000000)==0
end
function c501001004.thcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001004+200000000)==0 end
	Duel.RegisterFlagEffect(tp,501001004+200000000,RESET_PHASE+PHASE_END,0,1)
end	
function c501001004.thfilter(c)
	return c:IsAbleToHand()
	and c:IsType(TYPE_MONSTER)
	and c:IsType(TYPE_PENDULUM)
	and c:GetAttack()<=1500
end
function c501001004.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001004.thfilter,tp,LOCATION_DECK,0,1,nil)
	and c:IsDestructable()
	end
	Duel.SetOperationInfo(tp,CATEGORY_DESTROY,c,1,tp,LOCATION_SZONE)
	Duel.SetOperationInfo(tp,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(tp,CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end	
function c501001004.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(c501001004.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and c:IsDestructable() and c:IsRelateToEffect(e) then
		if Duel.Destroy(c,REASON_EFFECT)~=0 then
			local tg=g:Select(tp,1,1,nil)
			local tc=tg:GetFirst()
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
			Duel.ShuffleHand(tp)
		end
	end
end	
function c501001004.dcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp
	and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
	and Duel.GetAttackTarget()~=nil
end
function c501001004.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
