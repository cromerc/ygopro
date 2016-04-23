--Tuning Collapse
function c511000025.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000025.condition)
	e1:SetTarget(c511000025.target)
	e1:SetOperation(c511000025.operation)
	c:RegisterEffect(e1)
end
function c511000025.cfilter(c,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c511000025.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000025.cfilter,1,nil,tp)
end
function c511000025.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511000025.cfilter(chkc) end
	if chk==0 then return true end
	local g=eg:Filter(c511000025.cfilter,nil,e,tp)
	Duel.SetTargetCard(g)
	local tc1=Duel.GetFirstTarget()
	local desc=tc1:GetLevel()
	local desp=1-tp
	Duel.SetTargetPlayer(desp)
	Duel.SetTargetParam(desc)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,desp,desc)
end
function c511000025.operation(e,tp,eg,ep,ev,re,r,rp)
	local dp,dc=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(dp,dc,REASON_EFFECT)
end