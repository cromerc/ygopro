--Scripted by Eerie Code
--Hidden Shot
function c6412.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c6412.target)
	e1:SetOperation(c6412.activate)
	c:RegisterEffect(e1)
end

function c6412.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2016) and c:IsAbleToRemoveAsCost()
end
function c6412.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingMatchingCard(c6412.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local gc=Duel.GetMatchingGroupCount(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if gc>2 then gc=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c6412.cfilter,tp,LOCATION_GRAVE,0,1,gc,nil)
	local rc=Duel.Remove(g1,POS_FACEUP,REASON_COST)
	local g2=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,rc,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,g2:GetCount(),0,0)
end
function c6412.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end