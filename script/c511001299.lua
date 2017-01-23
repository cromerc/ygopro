--Shadow of Eyes
function c511001299.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001299.condition)
	e1:SetTarget(c511001299.target)
	e1:SetOperation(c511001299.activate)
	c:RegisterEffect(e1)
end
function c511001299.cfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c511001299.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001299.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c511001299.filter(c)
	return not c:IsPosition(POS_FACEUP_ATTACK)
end
function c511001299.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511001299.filter,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511001299.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511001299.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MUST_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc:RegisterFlagEffect(511001299,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		tc=g:GetNext()
	end
	local be=Effect.CreateEffect(e:GetHandler())
	be:SetType(EFFECT_TYPE_FIELD)
	be:SetCode(EFFECT_CANNOT_EP)
	be:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	be:SetTargetRange(0,1)
	be:SetCondition(c511001299.becon)
	be:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(be,tp)
end
function c511001299.befilter(c)
	return c:GetFlagEffect(511001299)~=0 and c:IsAttackable()
end
function c511001299.becon(e)
	return Duel.IsExistingMatchingCard(c511001299.befilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
