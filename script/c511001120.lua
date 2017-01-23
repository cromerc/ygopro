--Prophecy
function c511001120.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001120,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetHintTiming(0,TIMING_TOHAND+TIMING_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_SZONE)
	e1:SetOperation(c511001120.op)
	c:RegisterEffect(e1)
end
function c511001120.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1,nil)
	local tc=g:GetFirst()
	local atk=tc:GetAttack()
	local attackToCheck = 2000
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511001120,0))
	local op=Duel.SelectOption(tp,aux.Stringid(511001120,1),aux.Stringid(511001120,2),aux.Stringid(511001120,3))
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	if (op==0 and atk<2000) or (op==1 and tc:GetAttack() == attackToCheck) or (op==2 and atk>2000) then
	Duel.SendtoHand(tc,tp,REASON_EFFECT)
	end
end
