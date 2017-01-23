--Scripted by Eerie Code
--Performage Bonus Dealer
function c700000023.initial_effect(c)
	--Pendulum Summon
	aux.EnablePendulumAttribute(c)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c700000023.drcon)
	e2:SetTarget(c700000023.drtg)
	e2:SetOperation(c700000023.drop)
	c:RegisterEffect(e2)
	--lvatkup
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c700000023.lvcost)
	e2:SetTarget(c700000023.lvtg)
	e2:SetOperation(c700000023.lvop)
	c:RegisterEffect(e2)
end
function c700000023.drfil(c)
	return c:GetSummonType()==SUMMON_TYPE_PENDULUM and (c:IsSetCard(0xc6) or c:IsSetCard(0x9f)) and c:IsPreviousLocation(LOCATION_HAND)
end
function c700000023.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c700000023.drfil,3,nil)
end
function c700000023.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c700000023.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c700000023.lvfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c700000023.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000023.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c700000023.lvfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.PSendtoExtra(g,nil,REASON_COST)
end
function c700000023.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000023.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
