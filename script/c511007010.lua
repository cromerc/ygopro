--coded by Lyris
--Buried Destiny
function c511007010.initial_effect(c)
	--Activate only if a Spell Card your opponent already used in the Duel is not in their Graveyard. Select 1 card with the same name in your Graveyard and return it to the hand.
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511007010.target)
	e1:SetOperation(c511007010.activate)
	c:RegisterEffect(e1)
	if not c511007010.globle_check then
		c511007010.globle_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c511007010.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511007010.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if tc:IsType(TYPE_SPELL) then
		tc:RegisterFlagEffect(511007010,0,0,1)
		if tc:GetControler()==0 then tc:SetFlagEffectLabel(511007010,0) else tc:SetFlagEffectLabel(511007010,1) end
	end
end
function c511007010.filter(c,tp)
	return c:IsAbleToHand() and Duel.IsExistingMatchingCard(c511007010.chfilter,tp,0,0xef,1,nil,tp,c:GetCode())
end
function c511007010.chfilter(c,tp,code)
	return c:GetFlagEffectLabel(511007010)==1-tp and c:IsCode(code)
end
function c511007010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511007010.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511007010.filter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511007010.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511007010.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end