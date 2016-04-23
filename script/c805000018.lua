--武神器－ヘツカ
function c805000018.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000018,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c805000018.ngcon)
	e1:SetCost(c805000018.ngcost)
	e1:SetTarget(c805000018.ngtg)
	e1:SetOperation(c805000018.ngop)
	c:RegisterEffect(e1)
end
function c805000018.ngcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local loc,tg=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TARGET_CARDS)
	local tc=tg:GetFirst()
	if tg:GetCount()~=1 or not tc:IsLocation(LOCATION_MZONE) 
	 or not tc:IsSetCard(0x86) or not tc:IsControler(tp) then return false end
	return Duel.IsChainDisablable(ev) and loc~=LOCATION_DECK
end
function c805000018.ngcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c805000018.ngtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c805000018.ngop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateEffect(ev)
end
