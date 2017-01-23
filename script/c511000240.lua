--Exodia Necross
function c511000240.initial_effect(c)
	c:EnableReviveLimit()
	--"Exodia the Forbidden One": This card cannot be destroyed by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000240.battlecon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--"Left Leg of the Forbidden One": This card cannot be destroyed by Spell Cards.
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000240.spellcon)
	e3:SetValue(c511000240.spellval)
	c:RegisterEffect(e3)
	--"Right Leg of the Forbidden One": This card cannot be destroyed by Trap Cards.
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511000240.trapcon)
	e4:SetValue(c511000240.trapval)
	c:RegisterEffect(e4)
	--"Left Arm of the Forbidden One": This card cannot be destroyed by the effects of other Effect Monsters.
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511000240.monstercon)
	e5:SetValue(c511000240.monsterval)
	c:RegisterEffect(e5)
	--"Right Arm of the Forbidden One": Whenever this card battles an opponent's monster, it gains 1000 ATK at the end of the Damage Step.
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(511000240,0))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e6:SetCategory(CATEGORY_ATKCHANGE)
	e6:SetCode(EVENT_DAMAGE_STEP_END)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_REPEAT)
	e6:SetCondition(c511000240.atkcon)
	e6:SetOperation(c511000240.atkop)
	c:RegisterEffect(e6)
end
function c511000240.battlecon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,33396948)
end	
function c511000240.spellcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,44519536)
end	
function c511000240.spellval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL)
end
function c511000240.trapcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,8124921)
end
function c511000240.trapval(e,re,rp)
	return re:IsActiveType(TYPE_TRAP)
end
function c511000240.monstercon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,7902349)
end
function c511000240.monsterval(e,re,rp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c511000240.atkcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,70903634) and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil 
	or Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,70903634) and Duel.GetAttackTarget()==e:GetHandler() and Duel.GetAttackTarget()~=nil
end
function c511000240.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
	end
end