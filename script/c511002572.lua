--Dragonic Divine
function c511002572.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002572.condition)
	e1:SetCost(c511002572.cost)
	e1:SetTarget(c511002572.target)
	e1:SetOperation(c511002572.activate)
	c:RegisterEffect(e1)
	if not c511002572.global_check then
		c511002572.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c511002572.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002572.checkop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsType(TYPE_SPELL) then
		rc:RegisterFlagEffect(511002572,RESET_PHASE+PHASE_END,0,0)
	end
end
function c511002572.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(8) and c:IsRace(RACE_DRAGON)
end
function c511002572.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002572.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002572.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511002572.filter(c)
	return c:IsType(TYPE_SPELL) and c:GetFlagEffect(511002572)>0
end
function c511002572.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1
	local tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,ct)
	local check=false
	while tc and not check do
		ct=ct-1
		if c511002572.filter(tc) then
			check=true
		else
			tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,ct)
		end
	end
	if chk==0 then return tc and not tc:IsHasEffect(EFFECT_NECRO_VALLEY) and tc:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
end
function c511002572.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1
	local tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,ct)
	local check=false
	while tc and not check do
		ct=ct-1
		if c511002572.filter(tc) then
			check=true
		else
			tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,ct)
		end
	end
	if tc and not tc:IsHasEffect(EFFECT_NECRO_VALLEY) and tc:IsAbleToHand() then
		Duel.HintSelection(Group.FromCards(tc))
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
