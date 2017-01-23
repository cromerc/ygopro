--Cosmic Blast
function c511001104.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCost(c511001104.cost)
	e1:SetCondition(c511001104.condition)
	e1:SetTarget(c511001104.target)
	e1:SetOperation(c511001104.activate)
	c:RegisterEffect(e1)
end
function c511001104.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 end
	--oath effects
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c511001104.cfilter(c,tp)
	return c:GetPreviousControler()==tp and c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_DRAGON)
end
function c511001104.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511001104.cfilter,nil,tp)
	return g:GetCount()==1
end
function c511001104.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=eg:Filter(c511001104.cfilter,nil,tp):GetFirst()
	local dam=tc:GetAttack()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001104.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
