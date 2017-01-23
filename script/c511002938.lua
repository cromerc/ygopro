--Offerings to the Bound Deity
function c511002938.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002938.cost)
	e1:SetTarget(c511002938.target)
	e1:SetOperation(c511002938.activate)
	c:RegisterEffect(e1)
end
function c511002938.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,Duel.GetLP(tp)/2)
end
function c511002938.filter(c)
	return c:IsCode(100000432) and c:IsFaceup()
end
function c511002938.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002938.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0x94,2)
end
function c511002938.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511002938.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		tc:AddCounter(0x94,2)
	end
end
