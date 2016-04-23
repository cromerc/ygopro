--Magnet Warrior Omega Minus
function c170000112.initial_effect(c)
    --Cannot attack a minus
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetTarget(c170000112.attg)
	e1:SetCondition(c170000112.atcon)
	e1:SetValue(c170000112.atval)
	c:RegisterEffect(e1)
    --Must attack a plus
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c170000112.con)
	e2:SetTarget(c170000112.tg)
	e2:SetValue(c170000112.vala)
	c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_EP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCondition(c170000112.becon)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MUST_ATTACK)
	e4:SetCondition(c170000112.becon)
	c:RegisterEffect(e4)
end
function c170000112.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xAEF) or c:IsSetCard(0x5F1A62F) or c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123)
end
function c170000112.atcon(e)
	return Duel.IsExistingMatchingCard(c170000112.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c170000112.attg(e,c)
	return c:IsSetCard(0xAEF) or c:IsSetCard(0x5F1A62F) or c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123)
end
function c170000112.atval(e,c)
	return c==e:GetHandler()
end
function c170000112.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x26F4)
end
function c170000112.con(e,c,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return Duel.IsExistingMatchingCard(c170000112.filter,c:GetControler(),0,LOCATION_MZONE,1,nil) and c:IsAttackable()
and not c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123)
end
function c170000112.tg(e,c)
	return not (c:IsSetCard(0x26F4) and c:IsFaceup())
end
function c170000112.vala(e,c)
	return c==e:GetHandler()
end
function c170000112.befilter(c)
	return c:IsAttackable()
end
function c170000112.becon(e,c,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c170000112.filter,c:GetControler(),0,LOCATION_MZONE,1,nil) and c:IsAttackable()
	and not c:GetEquipGroup():IsExists(Card.IsCode,1,nil,170000123)
end