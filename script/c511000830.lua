--Overlay Blessing
function c511000830.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511000830.condition)
	e1:SetTarget(c511000830.target)
	e1:SetOperation(c511000830.activate)
	c:RegisterEffect(e1)
end
function c511000830.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_XYZ) and ep~=tp and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
function c511000830.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511000830.filter(c)
	return c:IsFaceup() and c:GetOverlayCount()>0
end
function c511000830.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local g=Duel.SelectMatchingCard(p,c511000830.filter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local d=g:GetFirst():GetOverlayCount()
		Duel.Draw(p,d,REASON_EFFECT)
	end
end
