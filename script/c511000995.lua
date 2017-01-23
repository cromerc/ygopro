--時読みの魔術師
function c511000995.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--negate and set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000995,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000995.discon)
	e2:SetTarget(c511000995.distg)
	e2:SetOperation(c511000995.disop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000995,1))
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000995.negcon)
	e3:SetTarget(c511000995.negtg)
	e3:SetOperation(c511000995.negop)
	c:RegisterEffect(e3)
end
function c511000995.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg or tg:GetCount()~=1 or not tg:GetFirst():IsType(TYPE_PENDULUM) or not tg:GetFirst():IsLocation(LOCATION_MZONE) then return false end
	return re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c511000995.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511000995.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end
	Duel.NegateActivation(ev)
	local g=eg:GetFirst()
	if re:GetHandler():IsRelateToEffect(re) and g:IsCanTurnSet() then
		Duel.BreakEffect()
		g:CancelToGrave()
		Duel.ChangePosition(g,POS_FACEDOWN)
		Duel.RaiseEvent(g,EVENT_SSET,e,REASON_EFFECT,1-tp,1-tp,0)
	end
end
function c511000995.negfilter(c)
	return c:IsOnField() and (c:GetSequence()==6 or c:GetSequence()==7)
end
function c511000995.negcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c511000995.negfilter,1,nil) and Duel.IsChainDisablable(ev)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511000995.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511000995.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
