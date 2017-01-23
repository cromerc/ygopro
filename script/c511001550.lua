--Empty Fishing
function c511001550.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001550.condition)
	e1:SetTarget(c511001550.target)
	e1:SetOperation(c511001550.operation)
	c:RegisterEffect(e1)
end
function c511001550.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511001550.filter(c)
	return c:IsFaceup() and c:IsDisabled() and c:IsAbleToHand()
end
function c511001550.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511001550.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001550.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511001550.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,2,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511001550.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511001550.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		sg:KeepAlive()
		local de=Effect.CreateEffect(e:GetHandler())
		de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		de:SetCode(EVENT_PHASE+PHASE_END)
		de:SetCountLimit(1)
		de:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		de:SetLabelObject(sg)
		de:SetCondition(c511001550.descon)
		de:SetOperation(c511001550.desop)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_END then
			de:SetLabel(Duel.GetTurnCount())
			de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			de:SetLabel(0)
			de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(de,tp)
	end
end
function c511001550.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev/2)
end
function c511001550.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
function c511001550.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Hint(HINT_CARD,0,511001550)
	g:DeleteGroup()
	Duel.SendtoGrave(g,REASON_EFFECT)
end
