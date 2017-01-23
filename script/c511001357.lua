--Remove Bomb
function c511001357.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCost(c511001357.cost)
	e1:SetTarget(c511001357.target)
	e1:SetOperation(c511001357.activate)
	c:RegisterEffect(e1)
end
function c511001357.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001357.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetDecktopGroup(tp,5)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return g:IsExists(Card.IsAbleToRemove,5,nil) end
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	local ct=g:FilterCount(Card.IsType,nil,TYPE_MONSTER)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel()*300)
end
function c511001357.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
