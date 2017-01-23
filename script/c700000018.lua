--Scripted by Eerie Code
--Abyss Script - Fantasy Magic
function c700000018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c700000018.target)
	e1:SetOperation(c700000018.operation)
	c:RegisterEffect(e1)
end
function c700000018.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x120e)
end
function c700000018.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c700000018.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000018.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c700000018.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000018.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(2356994,0))
		e1:SetCategory(CATEGORY_TOHAND)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_BATTLED)
		e1:SetTarget(c700000018.target2)
		e1:SetOperation(c700000018.operation2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c700000018.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and tc:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
end
function c700000018.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc:IsRelateToBattle() then
		Duel.SendtoHand(bc,nil,REASON_EFFECT)
	end
end
