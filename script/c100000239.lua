--エクシーズ・トレジャー
function c100000239.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000239.target)
	e1:SetOperation(c100000239.activate)
	c:RegisterEffect(e1)
end
function c100000239.gfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c100000239.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c100000239.gfilter,tp,LOCATION_MZONE,0,nil)
		local ct=Duel.GetMatchingGroupCount(c100000239.gfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		e:SetLabel(ct)
		return ct>0 and Duel.IsPlayerCanDraw(tp,ct)
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,e:GetLabel())
end
function c100000239.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c100000239.gfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=Duel.GetMatchingGroupCount(c100000239.gfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Draw(p,ct,REASON_EFFECT)
end
