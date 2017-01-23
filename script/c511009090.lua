--Offerings to the Bound Deity
function c511009090.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009090.cost)
	e1:SetTarget(c511009090.target)
	e1:SetOperation(c511009090.activate)
	c:RegisterEffect(e1)
end
function c511009090.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511009090.filter(c)
	return c:IsCode(100000432) and c:IsFaceup()
end
function c511009090.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009090.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0x94,2)
end
function c511009090.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511009090.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		tc:AddCounter(0x94,2)
	end
end
