--Raidraptor - Symbol
function c511001015.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001015.condition)
	e1:SetTarget(c511001015.target)
	e1:SetOperation(c511001015.activate)
	c:RegisterEffect(e1)
	if not c511001015.global_check then
		c511001015.global_check=true
		c511001015[0]=false
		c511001015[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511001015.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511001015.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001015.checkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if Duel.GetAttacker():IsSetCard(0xba) and at then
		c511001015[0]=true
		c511001015[1]=true
	end
end
function c511001015.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001015[0]=false
	c511001015[1]=false
end
function c511001015.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511001015[tp]
end
function c511001015.filter(c)
	return c:IsSetCard(0xba) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511001015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001015.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001015.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001015.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
