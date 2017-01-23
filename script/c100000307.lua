--穢された大地
function c100000307.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetTarget(c100000307.target)
	e1:SetOperation(c100000307.activate)
	c:RegisterEffect(e1)
	if not c100000307.global_check then
		c100000307.global_check=true
		c100000307[0]=true
		c100000307[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c100000307.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c100000307.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c100000307.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsStatus(STATUS_BATTLE_DESTROYED) and tc:GetLevel()>=5 and tc:IsPreviousPosition(POS_FACEUP)
			and tc:IsPreviousLocation(LOCATION_MZONE) then
			c100000307[tc:GetPreviousControler()]=true
		end
		tc=eg:GetNext()
	end
end
function c100000307.clear(e,tp,eg,ep,ev,re,r,rp)
	c100000307[0]=false
	c100000307[1]=false
end
function c100000307.filter(c,e,tp)
	return  c:IsSetCard(0x21) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000307.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c100000307[tp]
		and Duel.IsExistingMatchingCard(c100000307.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000307.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c100000307.filter,tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end
