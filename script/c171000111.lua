--セブンストア
function c171000111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c171000111.cost)
	e1:SetTarget(c171000111.target)
	e1:SetOperation(c171000111.activate)
	c:RegisterEffect(e1)
end
function c171000111.cfilter(c,tp)
	local ct=c:GetOverlayCount()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToGraveAsCost() 
		and Duel.IsPlayerCanDraw(tp,ct+1)
end
function c171000111.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c171000111.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c171000111.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c171000111.cfilter,1,1,nil,tp)
	local ct=g:GetFirst():GetOverlayCount()
	Duel.Release(g,REASON_COST)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c171000111.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,1,REASON_EFFECT)
	if d>1 then
		Duel.BreakEffect()
		Duel.Draw(tp,d-1,REASON_EFFECT)
	end
end
