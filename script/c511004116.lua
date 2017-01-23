--Victim Barrier
--scripted by:urielkama
function c511004116.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511004116.condition)
	e1:SetTarget(c511004116.target)
	e1:SetOperation(c511004116.activate)
	c:RegisterEffect(e1)
end
function c511004116.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511004116.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511004116.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	if g:GetCount()>0 then
		local a=Duel.GetAttacker()
		if Duel.ChangeAttackTarget(g:GetFirst())~=0 and g:GetFirst():GetCounter(0x1104)>0 then
		a:AddCounter(0x1104,1)
		end
	end
end