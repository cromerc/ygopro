--胡蝶の舞
function c511001026.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001026.cost1)
	c:RegisterEffect(e1)
	--Damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95178994,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,511001026)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511001026.cost2)
	e2:SetOperation(c511001026.op)
	c:RegisterEffect(e2)
end
function c511001026.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x6a) and not c:IsPublic()
end
function c511001026.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511001026.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001026.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c511001026.cfilter,tp,LOCATION_HAND,0,1,200,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	e:SetLabel(g:GetCount())
end
function c511001026.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Damage(1-tp,e:GetLabel()*300,REASON_EFFECT)
end
