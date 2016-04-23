--Scripted by Eerie Code
--Odd-Eyes Gravity Dragon
function c6843.initial_effect(c)
	c:EnableReviveLimit()
	--Back to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6843,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,6843)
	e1:SetTarget(c6843.thtg)
	e1:SetOperation(c6843.thop)
	c:RegisterEffect(e1)
	--pay
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6843,1))
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_ACTIVATE_COST)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetTarget(c6843.actarget)
	e3:SetCost(c6843.costchk)
	e3:SetOperation(c6843.costop)
	c:RegisterEffect(e3)	
end

function c6843.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c6843.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6843.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c6843.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	Duel.SetChainLimit(c6843.chlimit)
end
function c6843.chlimit(e,ep,tp)
	return tp==ep
end
function c6843.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c6843.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end

function c6843.actarget(e,te,tp)
	return te:IsActiveType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
end
function c6843.costchk(e,te_or_c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c6843.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
