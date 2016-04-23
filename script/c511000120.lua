--Cursed Twin Dolls
function c511000120.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Recover
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511000120.operation)
	c:RegisterEffect(e2)
	--discard deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000120,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000120.damcon)
	e3:SetTarget(c511000120.damtg)
	e3:SetOperation(c511000120.damop)
	c:RegisterEffect(e3)	
end
function c511000120.filter1(c,tp)
	return c:GetOwner()==1-tp
end

function c511000120.operation(e,tp,eg,ep,ev,re,r,rp)
	local d1=eg:FilterCount(c511000120.filter1,nil,tp)*200
	Duel.Recover(1-tp,d1,REASON_EFFECT)
end

function c511000120.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:GetPreviousControler()==tp
end
function c511000120.damcon(e,tp,eg,ep,ev,re,r,rp)
	return re and bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c511000120.cfilter,1,nil,1-tp) and re:GetHandler():GetCode()~=511000120
end
function c511000120.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_GRAVE,1,nil,TYPE_MONSTER) end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)*1
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,dam)
end
function c511000120.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)*1
	Duel.DiscardDeck(1-tp,dam,REASON_EFFECT)
end