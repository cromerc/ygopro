--Suit of Sword X
function c511000022.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c511000022.target)
    e1:SetOperation(c511000022.activate)
    c:RegisterEffect(e1)
end
function c511000022.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) and Duel.IsExistingMatchingCard(Card.IsDestructable,1-tp,LOCATION_MZONE,0,1,nil) end
    local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
    local sa=Duel.GetMatchingGroup(Card.IsDestructable,1-tp,LOCATION_MZONE,0,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,sa,sa:GetCount(),0,0)
end
function c511000022.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	else
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(g,REASON_EFFECT)
    end
end
