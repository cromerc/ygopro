--Pursuit of the Fiend
function c511001687.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c511001687.condition)
	e1:SetCost(c511001687.cost)
	e1:SetOperation(c511001687.activate)
	c:RegisterEffect(e1)
end
function c511001687.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsControler(tp) and tc:IsType(TYPE_XYZ) and tc:IsFaceup() 
		and tc:GetBattleTarget():IsDefensePos()
end
function c511001687.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local g=tc:GetOverlayGroup()
	Duel.SendtoGrave(g,REASON_COST)	
end
function c511001687.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
