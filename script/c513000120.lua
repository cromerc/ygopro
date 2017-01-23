--人造人間－サイコ・ロード
function c513000120.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c513000120.spcon)
	e2:SetOperation(c513000120.spop)
	c:RegisterEffect(e2)
	--cannot trigger
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0xa,0xa)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TRAP))
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TRAP))
	c:RegisterEffect(e4)
	--disable effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAIN_SOLVING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c513000120.disop)
	c:RegisterEffect(e5)
	--disable trap monster
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TRAP))
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(35803249,0))
	e7:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetTarget(c513000120.destg)
	e7:SetOperation(c513000120.desop)
	c:RegisterEffect(e7)
end
function c513000120.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) then
		Duel.NegateEffect(ev)
	end
end
function c513000120.spfilter(c)
	return c:IsFaceup() and c:IsCode(77585513) and c:IsAbleToGraveAsCost()
end
function c513000120.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c513000120.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c513000120.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c513000120.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c513000120.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_SZONE+LOCATION_HAND,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_SZONE+LOCATION_HAND,nil,TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sg:GetCount()*300)
end
function c513000120.desop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g2=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_SZONE,nil)
	g1:Merge(g2)
	Duel.ConfirmCards(tp,g1)
	Duel.ShuffleHand(1-tp)
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_SZONE+LOCATION_HAND,nil,TYPE_TRAP)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
end
