--Lost Pride
function c511000616.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCost(c511000616.cost)	
	e1:SetTarget(c511000616.target)
	e1:SetOperation(c511000616.activate)
	c:RegisterEffect(e1)
end
function c511000616.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c511000616.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000616.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	Duel.DiscardHand(tp,c511000616.cfilter,1,1,REASON_COST)
end
function c511000616.tgfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000616.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511000616.tgfilter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c511000616.activate(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.SelectMatchingCard(tp,c511000616.tgfilter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SendtoHand(g,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	g:GetFirst():RegisterFlagEffect(511000616,nil,0,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAIN_ACTIVATING)
	e1:SetOperation(c511000616.damop)
	e1:SetLabelObject(g:GetFirst())
	Duel.RegisterEffect(e1,tp)
end
function c511000616.damop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or re:GetHandler()~=e:GetLabelObject() then return end
	if e:GetLabelObject():GetFlagEffect(511000616)~=0 then
		Duel.Damage(tp,1000,REASON_EFFECT)
		e:GetLabelObject():ResetFlagEffect(511000616)
	end
end
