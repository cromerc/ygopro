--Flash of Dark Lightning
function c511002281.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c511002281.condition)
	e1:SetTarget(c511002281.target)
	e1:SetOperation(c511002281.activate)
	c:RegisterEffect(e1)
end
function c511002281.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp) and Duel.GetCurrentChain()==0
end
function c511002281.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
end
function c511002281.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(Card.IsControler,nil,1-tp)
	Duel.NegateSummon(eg)
end
