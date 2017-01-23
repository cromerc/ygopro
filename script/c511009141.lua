--Curse of the Dolls
function c511009141.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009141.condition)
	e1:SetTarget(c511009141.target)
	e1:SetOperation(c511009141.activate)
	c:RegisterEffect(e1)
end
--doll collection
c511009141.collection={
	[72657739]=true;[91939608]=true;[85639257]=true;[92418590]=true;
	[2903036]=true;[39806198]=true;[49563947]=true;[82579942]=true;
}
function c511009141.cfilter(c)
	return c:IsType(TYPE_MONSTER) and (c511009141.collection[c:GetCode()] or c:IsSetCard(0x20b) or c:IsSetCard(0x9d))
end
function c511009141.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009141.cfilter,tp,LOCATION_GRAVE,0,5,nil)
end
function c511009141.filter(c)
	return c:IsFacedown() and c:IsDefensePos() and c:IsDestructable()
end
function c511009141.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c511009141.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009141.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009141.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009141.activate(e)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
