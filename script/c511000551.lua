--Treasures of the Dead
function c511000551.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000551.target)
	e1:SetOperation(c511000551.activate)
	c:RegisterEffect(e1)
end
function c511000551.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,1,e:GetHandler(),TYPE_SPELL+TYPE_TRAP) end
	Duel.SetTargetPlayer(tp)
	local rec=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,e:GetHandler(),TYPE_SPELL+TYPE_TRAP)*500
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,rec)
end
function c511000551.activate(e,tp,eg,ep,ev,re,r,rp)
	local val=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,e:GetHandler(),TYPE_SPELL+TYPE_TRAP)*500
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,val,REASON_EFFECT)
end
