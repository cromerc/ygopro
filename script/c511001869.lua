--Resurrection Tribute
function c511001869.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001869.condition)
	e1:SetTarget(c511001869.target)
	e1:SetOperation(c511001869.activate)
	c:RegisterEffect(e1)
	if not c511001869.global_check then
		c511001869.global_check=true
		c511001869[0]=true
		c511001869[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DESTROYED)
		ge1:SetOperation(c511001869.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001869.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001869.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE) then
			c511001869[tc:GetPreviousControler()]=true
		end
		tc=eg:GetNext()
	end
end
function c511001869.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001869[0]=false
	c511001869[1]=false
end
function c511001869.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511001869[tp]
end
function c511001869.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511001869.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingMatchingCard(c511001869.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511001869.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c511001869.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
			if g:GetCount()>0 then
				Duel.BreakEffect()
				Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
			end
		end
	end
end
