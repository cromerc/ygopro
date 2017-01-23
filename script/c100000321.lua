--酔いどれタイガー
function c100000321.initial_effect(c)
	--Disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c100000321.disop)
	c:RegisterEffect(e1)
end
function c100000321.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if tc and tc:IsType(TYPE_FLIP) and tc:IsPreviousPosition(POS_FACEDOWN_DEFENSE)
	and Duel.GetAttacker()==c then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x17a0000)
		tc:RegisterEffect(e2)
	end
end

