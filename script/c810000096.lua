--Yosen Tornado
--scripted by: UnknownGuest
function c810000096.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c810000096.cost)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCondition(c810000096.condition)
	e2:SetTarget(c810000096.target)
	e2:SetOperation(c810000096.operation)
	c:RegisterEffect(e2)
end
function c810000096.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c810000096.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsSetCard(0xb3)
		and c:IsType(TYPE_MONSTER)
end
function c810000096.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c810000096.cfilter,1,nil,tp)
	--local ct=eg:Filter(c810000096.cfilter,nil,tp)
	--e:SetLabel(eg:GetCount())
end
function c810000096.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToHand() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	local ct=eg:FilterCount(c810000096.cfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local eg=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,ct,0,0)
end
function c810000096.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local rg=tg:Filter(Card.IsRelateToEffect,nil,e)
	--local rg=e:GetLabel()
	if rg:GetCount()>0 then 
		Duel.SendtoHand(rg,nil,REASON_EFFECT)
	end
end
