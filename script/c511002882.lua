--二角獣レーム
function c511002882.initial_effect(c)
	--deckdes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58685438,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511002882.ddcon)
	e1:SetTarget(c511002882.ddtg)
	e1:SetOperation(c511002882.ddop)
	c:RegisterEffect(e1)
	--syn limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c511002882.synlimit)
	c:RegisterEffect(e2)
end
function c511002882.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c511002882.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,2)
end
function c511002882.ddop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.DiscardDeck(p,2,REASON_EFFECT)
end
function c511002882.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_BEAST)
end
