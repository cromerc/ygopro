--Gottoms' Emergency Convocation
function c51370054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c51370054.condition)
	e1:SetTarget(c51370054.target)
	e1:SetOperation(c51370054.operation)
	c:RegisterEffect(e1)
	if not c51370054.global_check then
		c51370054.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c51370054.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c51370054.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c51370054.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not tc:IsSetCard(0x100d) then
			c51370054[tc:GetSummonPlayer()]=false
		end
		tc=eg:GetNext()
	end
end
function c51370054.clear(e,tp,eg,ep,ev,re,r,rp)
	c51370054[0]=true
	c51370054[1]=true
end
function c51370054.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c51370054[tp] end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c51370054.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c51370054.splimit(e,c)
	return not c:IsSetCard(0x100d)
end
function c51370054.sfilter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsSetCard(0x100d)
end
function c51370054.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c51370054.sfilter,tp,LOCATION_MZONE,0,1,nil) 
end
function c51370054.filter(c,e,tp)
	return  c:IsSetCard(0x100d) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c51370054.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c51370054.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c51370054.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c51370054.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c51370054.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<g:GetCount() then return end
	local tc=g:GetFirst()
	while tc do
		if Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP) then
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_SET_ATTACK_FINAL)
			e3:SetValue(0)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3,true)
		end
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
