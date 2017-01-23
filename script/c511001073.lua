--Death and Rebirth
function c511001073.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511001073.condition)
	e1:SetTarget(c511001073.target)
	e1:SetOperation(c511001073.operation)
	c:RegisterEffect(e1)
end
function c511001073.cfilter(c,e,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE) and c:IsType(TYPE_NORMAL)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001073.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001073.cfilter,nil,e,tp)
	local ph=Duel.GetCurrentPhase()
	return g:GetCount()==1 and Duel.GetTurnPlayer()==tp and ph>=0x08 and ph<=0x20
end
function c511001073.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,0,0)
end
function c511001073.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	if Duel.Destroy(dg,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		local g=eg:Filter(c511001073.cfilter,nil,e,tp)
		local tc=g:GetFirst()
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_MUST_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
