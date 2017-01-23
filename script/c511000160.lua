--Hyper Refresh
function c511000160.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000160.condition)
	e1:SetOperation(c511000160.activate)
	c:RegisterEffect(e1)
end
function c511000160.filter(c,e)
	return c:IsFaceup()
end
function c511000160.condition(e,tp,eg,ep,ev,re,r,rp)
	local atk=0
	local g=Duel.GetMatchingGroup(c511000160.filter,tp,0,LOCATION_MZONE,nil)
	local bc=g:GetFirst()
	while bc do
		atk=atk+bc:GetAttack()
		bc=g:GetNext()
	end
	local p=e:GetHandler():GetControler()
	return Duel.GetLP(p)<atk and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c511000160.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	Duel.SetLP(tp,(Duel.GetLP(p)*2),REASON_EFFECT)
end