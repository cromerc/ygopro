--Action Card - Cosmic Arrow
function c95000068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1)
	e1:SetCondition(c95000068.condition)
	e1:SetTarget(c95000068.target)
	e1:SetOperation(c95000068.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000068.handcon)
	c:RegisterEffect(e2)
end
function c95000068.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end

function c95000068.dfilter(c)
	return c:IsType(TYPE_SPELL)
end
function c95000068.filter(c,e,tp)
	return c:IsControler(tp) and (not c:IsReason(REASON_DRAW)) and (not e or c:IsRelateToEffect(e))
end
function c95000068.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c95000068.filter,1,nil,nil,1-tp)
end
function c95000068.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	Duel.SetChainLimit(c95000068.climit)
end
function c95000068.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c95000068.filter,nil,e,1-tp)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(1-ep,g)
	local dg=g:Filter(c95000068.dfilter,nil)
	Duel.Destroy(dg,REASON_EFFECT)
	Duel.ShuffleHand(ep)
end
function c95000068.climit(e,lp,tp)
	return lp==tp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
