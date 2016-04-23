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
function c171000111.filter(c)
	return c:IsFaceup() and bit.band(c:GetType(),0x800000)==0x800000 and c:IsAbleToGraveAsCost()
end
function c171000111.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c171000111.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c171000111.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetOverlayCount())
	Duel.SendtoGrave(g,REASON_COST)
end
function c171000111.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local drw=e:GetLabel()+1
	if chk==0 then return Duel.IsPlayerCanDraw(tp,drw) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(drw)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,drw)
end
function c171000111.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
