--ファイヤー・サイクロン
function c100000291.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c100000291.cost)
	e1:SetTarget(c100000291.target)
	e1:SetOperation(c100000291.operation)
	c:RegisterEffect(e1)
end
function c100000291.costfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsRace(RACE_PYRO)
end
function c100000291.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c100000291.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsType(TYPE_SPELL+TYPE_TRAP) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c100000291.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) 
			and Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP) end
	local rt=Duel.GetTargetCount(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000291.costfilter,tp,LOCATION_HAND,0,1,rt,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
	local ct=g:GetCount()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_ONFIELD,ct,ct,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c100000291.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local rg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if rg:GetCount()>0 then 
		Duel.Destroy(rg,nil,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(rg:GetCount())
		e1:SetOperation(c100000291.droperation)
		Duel.RegisterEffect(e1,tp)
	end
end
function c100000291.droperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,100000291)
	Duel.Draw(tp,e:GetLabel(),REASON_EFFECT)
end
