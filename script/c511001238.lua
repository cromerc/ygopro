--Split Defender
function c511001238.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001238.condition)
	e1:SetTarget(c511001238.ctltg)
	e1:SetOperation(c511001238.ctlop)
	c:RegisterEffect(e1)
end
function c511001238.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=2
end
function c511001238.filter(c)
	return c:IsControlerCanBeChanged() and c:IsFaceup()
end
function c511001238.ctltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001238.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c511001238.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001238.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local sg=g:GetMaxGroup(Card.GetDefense)
	if sg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		sg=sg:Select(1-tp,1,1,nil)
	end
	Duel.GetControl(sg:GetFirst(),tp)
end
