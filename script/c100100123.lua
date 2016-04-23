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
	return tc:GetCounter(0x91)>1
end
function c100100123.filter(c)
	return c:IsDestructable() and Duel.IsExistingMatchingCard(Card.IsDestructable,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function c100100123.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(c100100123.filter,tp,LOCATION_ONFIELD,0,1,nil) end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c100100123.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c100100123.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local sc=e:GetLabelObject()
	if sg:GetCount()~=2 or  sc:IsControler(1-tp) then return end
	Duel.Destroy(sg,REASON_EFFECT)
end
