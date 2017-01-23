--トゲトゲ神の殺虫剤
function c511002426.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002426.target)
	e1:SetOperation(c511002426.activate)
	c:RegisterEffect(e1)
end
function c511002426.cfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsFaceup() and c:IsDestructable()
end
function c511002426.filter(c,tp)
	return c:IsRace(RACE_INSECT) and (c:IsFaceup() or c:IsControler(tp)) and c:IsDestructable()
end
function c511002426.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002426.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511002426.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,1,0,0)
end
function c511002426.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511002426.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
