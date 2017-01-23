--Underworld Circle
function c513000118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c513000118.target)
	e1:SetOperation(c513000118.activate)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(512000007,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c513000118.sptg)
	e2:SetOperation(c513000118.spop)
	c:RegisterEffect(e2)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(513000118)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	if not c513000118.global_check then
		c513000118.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c513000118.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
	end
	
	local f=Card.IsCanBeSpecialSummoned
	Card.IsCanBeSpecialSummoned=function(c,e,tpe,tp,con,conr)
		if Duel.IsPlayerAffectedByEffect(tp,513000118) then return c:IsType(TYPE_MONSTER) and f(c,e,tpe,tp,true,conr) end
		return f(c,e,tpe,tp,con,conr)
	end
	local proc=Duel.SpecialSummonStep
	Duel.SpecialSummonStep=function(tc,tpe,sump,tp,check,limit,pos)
		if Duel.IsPlayerAffectedByEffect(sump,513000118) then proc(tc,tpe,sump,tp,true,limit,pos) else proc(tc,tpe,sump,tp,check,limit,pos) end
	end
	local proc2=Duel.SpecialSummon
	Duel.SpecialSummon=function(g,tpe,sump,tp,check,limit,pos)
		if Duel.IsPlayerAffectedByEffect(sump,513000118) then proc2(g,tpe,sump,tp,true,limit,pos) else proc2(g,tpe,sump,tp,check,limit,pos) end
	end
end
function c513000118.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c513000118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.GetMatchingGroup(c513000118.filter,tp,LOCATION_DECK,LOCATION_DECK,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,tg:GetCount(),0,0)
end
function c513000118.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local sg=Duel.GetMatchingGroup(c513000118.filter,tp,LOCATION_DECK,LOCATION_DECK,nil)
	local tg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
	if sg:GetCount()>0 then
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
function c513000118.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000118.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000118.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_GRAVE)
end
function c513000118.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000118.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c513000118.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
	end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000118.spfilter,1-tp,LOCATION_GRAVE,0,1,nil,e,1-tp)
		and Duel.SelectYesNo(1-tp,aux.Stringid(62742651,1)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(1-tp,c513000118.spfilter,1-tp,LOCATION_GRAVE,0,1,1,nil,e,1-tp)
		Duel.SpecialSummonStep(g2:GetFirst(),0,1-tp,1-tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c513000118.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsFaceup,nil)
	local tc=g:GetFirst()
	while tc do
		if Duel.IsPlayerAffectedByEffect(tc:GetSummonPlayer(),513000118) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x47e0000)
			e1:SetCondition(c513000118.recon)
			e1:SetValue(LOCATION_REMOVED)
			tc:RegisterEffect(e1,true)
		end
		tc=g:GetNext()
	end
end
function c513000118.recon(e)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and Duel.IsPlayerAffectedByEffect(c:GetSummonPlayer(),513000118)
end
