--無限光アイン・ソフ・オウル
function c513000051.initial_effect(c)
	--Activate to Grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c513000051.cost)
	e1:SetTarget(c513000051.target)
	c:RegisterEffect(e1)
	--swarm
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(102380,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c513000051.spcon)
	e2:SetTarget(c513000051.sptg)
	e2:SetOperation(c513000051.spop)
	c:RegisterEffect(e2)
	--cannot trigger
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetTargetRange(1,0)
	e3:SetCondition(c513000051.accon)
	e3:SetValue(c513000051.aclimit)
	c:RegisterEffect(e3)
	--sp summon sephylon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(2407147,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c513000051.sephcon)
	e4:SetCost(c513000051.sephcost)
	e4:SetTarget(c513000051.sephtg)
	e4:SetOperation(c513000051.sephop)
	c:RegisterEffect(e4)
	if not c513000051.global_check then
		c513000051.global_check=true
		c513000051[0]=0
		c513000051[1]=0
		c513000051[2]={}
		c513000051[3]={}
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c513000051.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
		local ge3=ge1:Clone()
		ge3:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge3,0)
	end
end
function c513000051.costfilter(c)
	return c:IsFaceup() and c:IsCode(100000013) and c:IsAbleToGraveAsCost()
end
function c513000051.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000051.costfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c513000051.costfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c513000051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c513000051.sptg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c513000051.spop)
		c513000051.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c513000051.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c513000051.spfilter(c,e,tp)
	return c:IsLevelAbove(10) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000051.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c513000051.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c513000051.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if not e:GetHandler():IsRelateToEffect(e) or ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000051.spfilter,tp,LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c513000051.accon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer() and Duel.GetCurrentPhase()==PHASE_STANDBY 
end
function c513000051.aclimit(e,re,tp)
	local rc=re:GetHandler()
	return re:GetActivateLocation()==LOCATION_MZONE and (rc:IsSetCard(0x4a) or rc:IsCode(74530899)) and not rc:IsImmuneToEffect(e)
end
function c513000051.cfilter(c,tp)
	return (c:IsSetCard(0x4a) or c:IsCode(74530899) or c:IsCode(8967776)) and c:IsFaceup() and c:GetSummonPlayer()==tp
end
function c513000051.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g1=eg:Filter(c513000051.cfilter,nil,tp)
	local g2=eg:Filter(c513000051.cfilter,nil,1-tp)
	local tc1=g1:GetFirst()
	while tc1 do
		if c513000051[tp]==0 then
			c513000051[2+tp][1]=tc1:GetCode()
			c513000051[tp]=c513000051[tp]+1
		else
			local chk=true
			for i=1,c513000051[tp]+1 do
				if c513000051[2+tp][i]==tc1:GetCode() then
					chk=false
				end
			end
			if chk then
				c513000051[2+tp][c513000051[tp]+1]=tc1:GetCode()
				c513000051[tp]=c513000051[tp]+1
			end
		end
		tc1=g1:GetNext()
	end
	while tc2 do
		if c513000051[1-tp]==0 then
			c513000051[2+1-tp][1]=tc2:GetCode()
			c513000051[1-tp]=c513000051[1-tp]+1
		else
			local chk=true
			for i=1,c513000051[1-tp]+1 do
				if c513000051[2+1-tp][i]==tc2:GetCode() then
					chk=false
				end
			end
			if chk then
				c513000051[2+1-tp][c513000051[1-tp]+1]=tc2:GetCode()
				c513000051[1-tp]=c513000051[1-tp]+1
			end
		end
		tc2=g2:GetNext()
	end
end
function c513000051.sephcon(e,tp,eg,ep,ev,re,r,rp)
	return c513000051[tp]>=10
end
function c513000051.sephcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c513000051.filter(c,e,tp)
	return c:IsCode(8967776) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c513000051.sephtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c513000051.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c513000051.sephop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000051.filter,tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
