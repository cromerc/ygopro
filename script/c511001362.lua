--Card of the Dragon King
function c511001362.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001362.target)
	e1:SetOperation(c511001362.activate)
	c:RegisterEffect(e1)
end
function c511001362.filter(c)
	return c:IsReleasableByEffect() and c:IsRace(RACE_DRAGON)
end
function c511001362.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=Duel.GetMatchingGroup(c511001362.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return sg:GetCount()>0 and Duel.IsPlayerCanDraw(tp,sg:GetCount()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,sg:GetSum(Card.GetAttack))
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001362.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local sg=Duel.GetMatchingGroup(c511001362.filter,tp,LOCATION_MZONE,0,nil)
	local atk=sg:GetSum(Card.GetAttack)
	if Duel.Release(sg,REASON_EFFECT)>0 then
		sg=Duel.GetOperatedGroup()
		Duel.Damage(p,atk,REASON_EFFECT)
		Duel.Draw(p,sg:GetCount(),REASON_EFFECT)
	end
end
