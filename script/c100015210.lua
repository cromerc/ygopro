--
function c100015210.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterEqualFunction(Card.GetLevel,9),2)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(100015210,0))
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c100015210.cost)
	e1:SetOperation(c100015210.operation)
	c:RegisterEffect(e1)
end
function c100015210.cost(e,tp,eg,ep,ev,re,r,rp,chk)	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()	
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	if tc and tc:IsAbleToRemoveAsCost() then 
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	else 
	return false 
	end	
end
function c100015210.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(tc:GetBaseAttack()/2)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_FIELD)
        e1:SetCode(EFFECT_CHANGE_DAMAGE)
        e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
        e1:SetTargetRange(0,1)
        e1:SetValue(0)
        e1:SetReset(RESET_PHASE+PHASE_END)
        Duel.RegisterEffect(e1,tp)
end