--The Necloth of Valkyrus
function c13700044.initial_effect(c)	
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c13700044.splimit)
	c:RegisterEffect(e1)
	--end battle phase
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,13700044)
	e2:SetCondition(c13700044.condition)
	e2:SetCost(c13700044.cost)
	e2:SetOperation(c13700044.operation)
	c:RegisterEffect(e2)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,13700044)
	e3:SetCost(c13700044.dcost)
	e3:SetOperation(c13700044.doperation)
	c:RegisterEffect(e3)
end
--~ Ritual Summoned
function c13700044.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
--~ Negate Attack
function c13700044.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp
end
function c13700044.cfilter(c)
	return c:IsSetCard(0x1373) and c:IsAbleToRemoveAsCost()
end
function c13700044.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() and Duel.IsExistingMatchingCard(c13700044.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
end
function c13700044.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13700044.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if	Duel.Remove(g,POS_FACEUP,REASON_COST)	then
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
		Duel.NegateAttack() 
			Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
--~ Draw
function c13700044.dcost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsType,1,e:GetHandler(),TYPE_MONSTER) end
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,Card.IsReleasableByEffect,1,nil) end
	local g=Duel.SelectReleaseGroupEx(tp,Card.IsReleasableByEffect,1,2,nil)
	Duel.Release(g,REASON_EFFECT)
	e:SetLabel(g:GetCount())
end
function c13700044.doperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Draw(tp,e:GetLabel(),REASON_EFFECT)
end
