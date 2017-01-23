-- Null and Void (Anime)
-- scripted by: UnknownGuest
function c810000055.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000055,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c810000055.drcon)
	e1:SetTarget(c810000055.drtg)
	e1:SetOperation(c810000055.drop)
	c:RegisterEffect(e1)
	-- Activate(summon)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(810000055,1))
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SUMMON)
	e2:SetCondition(c810000055.sumcon)
	e2:SetTarget(c810000055.sumtg)
	e2:SetOperation(c810000055.sumop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	-- Activate (MSET and SSET)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_MSET)
	e4:SetTarget(c810000055.settg)
	e4:SetOperation(c810000055.setop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SSET)
	c:RegisterEffect(e5)
	-- Activate(effect)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(810000055,2))
	e5:SetCategory(CATEGORY_NEGATE+CATEGORY_TOGRAVE)
	e5:SetType(EFFECT_TYPE_ACTIVATE)
	e5:SetCode(EVENT_CHAINING)
	e5:SetCondition(c810000055.accon)
	e5:SetTarget(c810000055.actg)
	e5:SetOperation(c810000055.acop)
	c:RegisterEffect(e5)
end
function c810000055.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c810000055.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c810000055.drop(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(Card.IsRelateToEffect,nil,e):Filter(Card.IsControler,nil,1-tp)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
function c810000055.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetCurrentChain()==0
end
function c810000055.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,eg,eg:GetCount(),0,0)
end
function c810000055.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoGrave(eg,REASON_EFFECT)
end
function c810000055.setfilter(c,tp)
	return c:IsFacedown() and c:GetReasonPlayer()==tp and c:IsPreviousLocation(LOCATION_HAND)
end
function c810000055.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local sg=eg:Filter(c810000055.setfilter,nil,1-tp)
		return sg:GetCount()==1
	end
	local sg1=eg:Filter(c810000055.setfilter,nil,1-tp)
	Duel.SetTargetCard(sg1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg1,sg1:GetCount(),0,0)
end
function c810000055.setop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsRelateToEffect,nil,e):Filter(Card.IsControler,nil,1-tp)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c810000055.accon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and (re:GetHandler():IsPreviousLocation(LOCATION_HAND) or Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_HAND) 
		and Duel.IsChainNegatable(ev)
end
function c810000055.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToGrave() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,eg,1,0,0)
	end
end
function c810000055.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SendtoGrave(eg,REASON_EFFECT)
	end
end
