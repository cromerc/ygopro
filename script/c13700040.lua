--Chronomaly Gordias Unite
function c13700040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c13700040.stgcon)
	e2:SetTarget(c13700040.stgtg)
	e2:SetOperation(c13700040.stgop)
	c:RegisterEffect(e2)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c13700040.sdcon)
	c:RegisterEffect(e1)
end
function c13700040.stgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c13700040.tgfilter(c)
	return c:IsSetCard(0x1379) and c:IsAbleToGrave()
end
function c13700040.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700040.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_DECK)
end
function c13700040.stgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c13700040.tgfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,2,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end

function c13700040.sdfilter(c)
	return c:IsFaceup() and not c:IsSetCard(0x1379)
end
function c13700040.sdcon(e)
	return Duel.IsExistingMatchingCard(c13700040.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
