--Victim Barrier
--scripted by Keddy
function c511011001.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511011001.condition)
	e1:SetTarget(c511011001.target)
	e1:SetOperation(c511011001.activate)
	c:RegisterEffect(e1)
end
function c511011001.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511011001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511011001.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(tc)
		if tc:GetCounter(0x109a)>0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_DAMAGE_STEP_END)
			e1:SetOperation(c511011001.ctop)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c511011001.ctop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a and a:IsRelateToBattle() then
		a:AddCounter(0x109a,1)
	end
end
