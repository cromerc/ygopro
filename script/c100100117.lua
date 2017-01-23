--Ｓｐ－ギャップ・ストーム
function c100100117.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100117.con)
	e1:SetTarget(c100100117.target)
	e1:SetOperation(c100100117.activate)
	c:RegisterEffect(e1)
end
function c100100117.con(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetFieldCard(tp,LOCATION_SZONE,5) or not Duel.GetFieldCard(1-tp,LOCATION_SZONE,5) then return false end
	local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5):GetCounter(0x91)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5):GetCounter(0x91)
	return tc1-tc2>=7 or tc2-tc1>=7 
end
function c100100117.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_SZONE,LOCATION_SZONE,1,c) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_SZONE,LOCATION_SZONE,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100100117.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
