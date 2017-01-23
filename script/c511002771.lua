--サイレント・ウォビー
function c511002771.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511002771,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002771.sumtg)
	e1:SetOperation(c511002771.sumop)
	c:RegisterEffect(e1)
end
function c511002771.filter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsControlerCanBeChanged()
end
function c511002771.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002771.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002771.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511002771.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c511002771.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		if Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)>0 then
			Duel.GetControl(tc,tp)
		end
	end
end
