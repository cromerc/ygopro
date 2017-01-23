--Warrior's Supervision
--fixed by MLD
function c511009111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511009111.condition)
	e1:SetCost(c511009111.cost)
	e1:SetTarget(c511009111.target)
	e1:SetOperation(c511009111.activate)
	c:RegisterEffect(e1)
end
function c511009111.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511009111.cfilter(c)
	return c:GetAttack()>0 and c:IsRace(RACE_WARRIOR) and c:IsDiscardable()
end
function c511009111.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511009111.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511009111.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c511009111.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	local atk=g:GetFirst():GetBaseAttack()
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	Duel.SetTargetParam(atk)
	Duel.SetTargetCard(tc)
end
function c511009111.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end

