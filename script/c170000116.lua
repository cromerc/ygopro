--Conduction Warrior Linear Magnum Plus Minus
function c170000116.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c170000116.spcon)
	e1:SetOperation(c170000116.spop)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c170000116.atktg)
	e2:SetOperation(c170000116.atkop)
	c:RegisterEffect(e2)
	--Must attack a plus/ minus
    local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetCondition(c170000116.con)
	e3:SetTarget(c170000116.tg)
	e3:SetValue(c170000116.vala)
	c:RegisterEffect(e3)
    local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_EP)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,0)
	e4:SetCondition(c170000116.becon)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_MUST_ATTACK)
	e5:SetCondition(c170000116.becon)
	c:RegisterEffect(e5)
end
function c170000116.spfilter(c)
	return c:IsSetCard(0x26F4) or c:IsSetCard(0x5F1A62F) and c:IsAbleToGraveAsCost()
end
function c170000116.spfilter2(c)
	return c:IsSetCard(0xAEF) or c:IsSetCard(0x5F1A62F) and c:IsAbleToGraveAsCost()
end
function c170000116.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c170000116.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,c)
	and Duel.IsExistingMatchingCard(c170000116.spfilter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,c)
end
function c170000116.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c170000116.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,c)
    local g2=Duel.SelectMatchingCard(tp,c170000116.spfilter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,c)	
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SendtoGrave(g2,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c170000116.filter(c)
	return c:IsSetCard(0xAEF) or c:IsSetCard(0x26F4) or c:IsSetCard(0x5F1A62F) or c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123)
end
function c170000116.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c170000116.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c170000116.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c170000116.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c170000116.atkop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetCount()>0 then
		local atk=0
		local tc=g:GetFirst()
	    while tc do
	    atk=atk+tc:GetAttack()
	    tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk/2)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c170000116.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xAEF) or c:IsSetCard(0x26F4) or c:IsSetCard(0x5F1A62F) or c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123)
end
function c170000116.con(e,c)
local c=e:GetHandler()
return Duel.IsExistingMatchingCard(c170000116.cfilter,c:GetControler(),0,LOCATION_MZONE,1,nil) and c:IsAttackable()
end
function c170000116.tg(e,c)
	return not (c:IsSetCard(0xAEF) or c:IsSetCard(0x26F4) or c:IsSetCard(0x5F1A62F) or c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123) and c:IsFaceup())
end
function c170000116.vala(e,c)
	return c==e:GetHandler()
end
function c170000116.befilter(c)
	return c:IsAttackable()
end
function c170000116.becon(e,c)
local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c170000116.cfilter,c:GetControler(),0,LOCATION_MZONE,1,nil) and c:IsAttackable()
end