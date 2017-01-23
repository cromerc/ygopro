--Goblin Dancers
function c511002937.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74875003,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002937.sptg)
	e1:SetOperation(c511002937.spop)
	c:RegisterEffect(e1)
	--to defense
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002937.poscon)
	e2:SetOperation(c511002937.posop)
	c:RegisterEffect(e2)
end
function c511002937.spfilter(c,e,tp)
	return c:IsCode(511002937) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002937.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002937.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002937.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>2 then ft=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002937.spfilter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511002937.cfilter(c)
	return c:IsFaceup() and c:GetAttackedCount()>0 and c:IsCode(511002937)
end
function c511002937.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002937.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002937.filter(c)
	return c:IsFaceup() and c:IsCode(511002937) and c:IsAttackPos()
end
function c511002937.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002937.filter,tp,LOCATION_MZONE,0,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_COPY_INHERIT)
		if Duel.GetTurnPlayer()==tp then
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
