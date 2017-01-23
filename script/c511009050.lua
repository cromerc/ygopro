--Red Dragon Archfiend
function c511009050.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70902743,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c511009050.condition1)
	e1:SetTarget(c511009050.target1)
	e1:SetOperation(c511009050.operation1)
	c:RegisterEffect(e1)
	--destroy2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70902743,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c511009050.condition2)
	e2:SetTarget(c511009050.target2)
	e2:SetOperation(c511009050.operation2)
	c:RegisterEffect(e2)
	if not c511009050.global_check then
		c511009050.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c511009050.check)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ATTACK_DISABLED)
		ge2:SetOperation(c511009050.check2)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_SUMMON_SUCCESS)
		ge3:SetOperation(c511009050.checkop)
		Duel.RegisterEffect(ge3,0)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge4:SetOperation(c511009050.checkop)
		Duel.RegisterEffect(ge4,0)
	end
end
function c511009050.check(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetFlagEffectLabel(95100760)
	if ct then
		tc:SetFlagEffectLabel(95100760,ct+1)
	else
		tc:RegisterFlagEffect(95100760,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,1)
	end
end
function c511009050.check2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetFlagEffectLabel(95100760)
	if ct then
		tc:SetFlagEffectLabel(95100760,ct-1)
	end
end
function c511009050.checkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_MAIN2 or Duel.GetCurrentPhase()==PHASE_END then
		local tc=eg:GetFirst()
		while tc do
			local ct=tc:GetFlagEffectLabel(95100760)
			if ct then
				tc:SetFlagEffectLabel(95100760,ct+1)
			else
				tc:RegisterFlagEffect(95100760,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,1)
			end
			tc=eg:GetNext()
		end
	end
	
	
end
function c511009050.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget() and not Duel.GetAttackTarget():IsAttackPos()
end
function c511009050.filter1(c)
	return not c:IsAttackPos() and c:IsDestructable()
end
function c511009050.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511009050.filter1,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009050.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009050.filter1,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c511009050.filter2(c)
	local ct=c:GetFlagEffectLabel(95100760)
	return (not ct or ct==0) and c:IsDestructable()
end
function c511009050.condition2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511009050.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511009050.filter2,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009050.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c511009050.filter2,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end
