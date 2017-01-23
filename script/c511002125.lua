--リジェクト・リボーン
function c511002125.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002125.condition)
	e1:SetTarget(c511002125.target)
	e1:SetOperation(c511002125.activate)
	c:RegisterEffect(e1)
	if not c511002125.global_check then
		c511002125.global_check=true
		c511002125[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_DISABLED)
		ge1:SetOperation(c511002125.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002125.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002125.checkop(e,tp,eg,ep,ev,re,r,rp)
	c511002125[0]=c511002125[0]+1
end
function c511002125.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002125[0]=0
end
function c511002125.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp)
end
function c511002125.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511002125.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002125.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 or sg:GetCount()==0 then
		Duel.BreakEffect()
		local ct=c511002125[0]
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<ct then return end
		local g=Duel.GetMatchingGroup(c511002125.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
		if g:GetCount()>=ct then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sumg=g:Select(tp,ct,ct,nil)
			Duel.SpecialSummon(sumg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
