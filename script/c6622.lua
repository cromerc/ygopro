--Scripted by Eerie Code
--Knight of the Beginning
function c6622.initial_effect(c)
	--Search Spell
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6622,2))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,6622)
	e1:SetCondition(c6622.thcon)
	e1:SetTarget(c6622.thtg)
	e1:SetOperation(c6622.thop)
	c:RegisterEffect(e1)
	--Become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCountLimit(1,6623)
	e2:SetCondition(c6622.condition)
	e2:SetOperation(c6622.operation)
	c:RegisterEffect(e2)
end

function c6622.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp
end
function c6622.thfilter(c)
	return bit.band(c:GetType(),0x82)==0x82 and c:IsAbleToHand()
end
function c6622.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6621.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6622.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6622.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c6622.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c6622.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(6622)==0 then
			--Banish monster
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(6622,0))
			e1:SetCategory(CATEGORY_REMOVE)
			e1:SetType(EFFECT_TYPE_IGNITION)
			e1:SetRange(LOCATION_MZONE)
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e1:SetCountLimit(1)
			e1:SetTarget(c6622.rmtg1)
			e1:SetOperation(c6622.rmop1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e1)
			--Chain attack
			local e3=Effect.CreateEffect(c)
			e3:SetDescription(aux.Stringid(6622,1))
			e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
			e3:SetCode(EVENT_BATTLED)
			e3:SetCondition(c6622.atcon)
			e3:SetOperation(c6622.atop)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e3)
			rc:RegisterFlagEffect(6622,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end
function c6622.rmtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c6622.rmop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end

function c6622.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE) 
end
function c6622.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end