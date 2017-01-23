--Xyz Bento
function c511001691.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c511001691.condition)
	e1:SetOperation(c511001691.activate)
	c:RegisterEffect(e1)
end
function c511001691.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsType(TYPE_XYZ) and tc:IsFaceup() 
		and tc:GetBattleTarget():IsDefenseAbove(2000)
end
function c511001691.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		Duel.Overlay(tc,Group.FromCards(bc))
	end
end
