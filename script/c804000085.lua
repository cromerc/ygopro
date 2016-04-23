--Ghost Fairy Elfobia
function c804000085.initial_effect(c)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(804000085,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c804000085.cost)
	e1:SetOperation(c804000085.operation)
	c:RegisterEffect(e1)
end
function c804000085.cffilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and not c:IsPublic()
end
function c804000085.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c804000085.cffilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c804000085.cffilter,tp,LOCATION_HAND,0,1,1,nil)
	e:SetLabel(cg:GetFirst():GetLevel())
	Duel.ConfirmCards(1-tp,cg)
	Duel.ShuffleHand(tp)
end
function c804000085.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetLabel(e:GetLabel())
	e1:SetValue(c804000085.aclimit1)
	e1:SetReset(RESET_PHASE+PHASE_MAIN1+RESET_OPPO_TURN,1)
	Duel.RegisterEffect(e1,tp)
end
function c804000085.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():GetLevel()>e:GetLabel()
end