--Explosive Breakout
function c511001773.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c511001773.condition)
	e1:SetOperation(c511001773.activate)
	c:RegisterEffect(e1)
end
function c511001773.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsControler(tp) and tc:IsFaceup() and tc:GetBattleTarget():GetPreviousControler()==1-tp 
		and tc:GetBattleTarget():IsLevelAbove(8) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
end
function c511001773.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.ChainAttack()
	end
end
