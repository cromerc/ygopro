--Disgraceful Charity
function c511001144.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c511001144.condition)
	e1:SetTarget(c511001144.target)
	e1:SetOperation(c511001144.activate)
	c:RegisterEffect(e1)
	if not c511001144.global_check then
		c511001144.global_check=true
		c511001144[0]=false
		c511001144[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DISCARD)
		ge1:SetOperation(c511001144.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511001144.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001144.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local re=tc:GetReasonEffect()
	if re==nil then return end
	while tc do
		if tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_DISCARD) and re:IsActiveType(TYPE_SPELL) then
			c511001144[tc:GetControler()]=true
		end
		tc=eg:GetNext()
	end
end
function c511001144.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001144[0]=false
	c511001144[1]=false
end
function c511001144.filter(c,id,e,tp)
	local re=c:GetReasonEffect()
	return c:IsReason(REASON_DISCARD) and c:GetTurnID()==id and c:IsAbleToHand() and re:IsActiveType(TYPE_SPELL)
end
function c511001144.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511001144[tp] and Duel.GetFlagEffect(tp,511001144)==0
end
function c511001144.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001144.filter,tp,LOCATION_GRAVE,0,1,nil,Duel.GetTurnCount(),e,tp) 
		and Duel.IsExistingMatchingCard(c511001144.filter,tp,0,LOCATION_GRAVE,1,nil,Duel.GetTurnCount(),e,tp) 
		or Duel.IsExistingMatchingCard(c511001144.filter,tp,LOCATION_GRAVE,0,1,nil,Duel.GetTurnCount(),e,tp)
		or Duel.IsExistingMatchingCard(c511001144.filter,tp,0,LOCATION_GRAVE,1,nil,Duel.GetTurnCount(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_GRAVE)
	Duel.RegisterFlagEffect(tp,511001144,0,0,1)
end
function c511001144.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001144.filter,tp,LOCATION_GRAVE,0,1,999999,nil,Duel.GetTurnCount(),e,tp)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOHAND)
	local g2=Duel.SelectMatchingCard(1-tp,c511001144.filter,1-tp,LOCATION_GRAVE,0,1,999999,nil,Duel.GetTurnCount(),e,1-tp)
	if g2:GetCount()>0 then
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
	end
end
