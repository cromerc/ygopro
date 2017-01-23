--Mosquito Commando
function c511002148.initial_effect(c)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002148.con)
	e1:SetCost(c511002148.cost)
	e1:SetTarget(c511002148.tg)
	e1:SetOperation(c511002148.op)
	c:RegisterEffect(e1)
end
function c511002148.cfilter(c)
	return c:IsFaceup() and c:IsCode(511001339)
end
function c511002148.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002148.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511002148.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511002148.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0x1101,1)
end
function c511002148.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		tc:AddCounter(0x1101,1)
	end
end
