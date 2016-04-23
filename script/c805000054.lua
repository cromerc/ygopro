--Ｎｏ．６６覇鍵甲虫 マスター・キー・ビートル
function c805000054.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),4),2)
	c:EnableReviveLimit()
	local sg=Group.CreateGroup()
	sg:KeepAlive()
	--set target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000054,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c805000054.cost)
	e1:SetTarget(c805000054.target)
	e1:SetOperation(c805000054.operation)
	e1:SetLabelObject(sg)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c805000054.targetd)
	e2:SetValue(1)
	e2:SetLabelObject(sg)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c805000054.reptg)
	e3:SetLabelObject(sg)
	c:RegisterEffect(e3)
end
function c805000054.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c805000054.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_ONFIELD) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
end
function c805000054.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	local sg=e:GetLabelObject()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	sg:AddCard(tc)
end
function c805000054.targetd(e,c)
	local g=e:GetLabelObject()
	return g:IsContains(c)
end
function c805000054.tgfilter(c,e)
	local g=e:GetLabelObject()
	return g:IsContains(c) and c:IsAbleToGrave()
end
function c805000054.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c805000054.tgfilter,tp,LOCATION_ONFIELD,0,nil,e)
	if chk==0 then return g:GetCount()>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(110000000,10)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
		return true
	else return false end
end
