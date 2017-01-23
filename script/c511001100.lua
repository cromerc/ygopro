--Dragon King's Demise
function c511001100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001100.target)
	e1:SetOperation(c511001100.activate)
	c:RegisterEffect(e1)
end
function c511001100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,ct,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511001100.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0,nil)
	if Duel.IsExistingMatchingCard(Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,ct,nil) then
		local g=Duel.GetMatchingGroup(Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,nil)
		if Duel.Release(g,REASON_EFFECT)>0 then
			g=g:Filter(Card.IsRace,nil,RACE_DRAGON)
			local sum=g:GetSum(Card.GetAttack)
			Duel.BreakEffect()
			Duel.Damage(tp,sum,REASON_EFFECT,true)
			Duel.Damage(1-tp,sum,REASON_EFFECT,true)
			Duel.RDComplete()
		end
	end
end
