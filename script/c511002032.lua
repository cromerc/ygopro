--Assault Blackwing - Kunisada the Fogbow
function c511002032.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()	
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c511002032.thcost)
	e3:SetTarget(c511002032.thtg)
	e3:SetOperation(c511002032.thop)
	c:RegisterEffect(e3)
end
function c511002032.filter(c)
	return c:IsSetCard(0x33) and c:IsLevelBelow(3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511002032.synfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and c:IsType(TYPE_SYNCHRO)
end
function c511002032.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511002032.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511002032.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002032.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511002032.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511002032.thop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstTarget()
	if tg and tg:IsRelateToEffect(e) and Duel.SendtoHand(tg,nil,REASON_EFFECT)~=0 then
		Duel.ConfirmCards(1-tp,tg)
		local atk=tg:GetAttack()
		local g=Duel.GetMatchingGroup(c511002032.synfilter,tp,LOCATION_MZONE,0,nil)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
