--Perfect Counter Code 123
function c511002457.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c511002457.condition)
	e1:SetTarget(c511002457.target)
	e1:SetOperation(c511002457.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
end
function c511002457.filter(c,lv)
	return c:IsFaceup() and c:GetLevel()==lv
end
function c511002457.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	return Duel.GetCurrentChain()==0 and eg:IsExists(Card.IsControler,1,nil,1-tp) and g:GetCount()==3 
		and g:IsExists(c511002457.filter,1,nil,1) and g:IsExists(c511002457.filter,1,nil,2) and g:IsExists(c511002457.filter,1,nil,3)
end
function c511002457.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(Card.IsControler,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511002457.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsControler,nil,1-tp)
	Duel.NegateSummon(g)
	Duel.Destroy(g,REASON_EFFECT)
end
