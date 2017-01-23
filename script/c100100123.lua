--Ｓｐ－ハイスピード・クラッシュ
function c100100123.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100123.con)
	e1:SetTarget(c100100123.target)
	e1:SetOperation(c100100123.operation)
	c:RegisterEffect(e1)
end
function c100100123.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>1
end
function c100100123.filter(c,card)
	return c:IsDestructable() and Duel.IsExistingTarget(c100100123.filter2,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,card)
end
function c100100123.filter2(c,card)
	return c:IsDestructable() and c~=card
end
function c100100123.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c100100123.filter,tp,LOCATION_ONFIELD,0,1,c,c) end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c100100123.filter,tp,LOCATION_ONFIELD,0,1,1,c,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c100100123.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c100100123.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end
