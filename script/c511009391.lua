--C/C/C Water Sword of Battle
function c511009391.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	if Card.IsFusionAttribute then
		aux.AddFusionProcCodeFun(c,511009400,c511009390.ffilter1,1,true,true)
	else
		aux.AddFusionProcCodeFun(c,511009400,c511009390.ffilter2,1,true,true)
	end
	--adup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c511009391.atktg)
	e1:SetOperation(c511009391.atkop)
	c:RegisterEffect(e1)
end
function c511009390.ffilter1(c)
	return c:IsFusionAttribute(ATTRIBUTE_WATER) and (c:GetLevel()==5 or c:GetLevel()==6)
end
function c511009390.ffilter2(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and (c:GetLevel()==5 or c:GetLevel()==6)
end
function c511009391.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511009391.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009391.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511009391.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c511009391.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c)
		local atk=g:GetSum(Card.GetAttack)
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
		end
	end
end
function c511009391.ffilter(c,e,tp)
	return c:IsCanBeFusionMaterial() and c:IsAttribute(ATTRIBUTE_WATER) and (c:GetLevel()==5 or c:GetLevel()==6)
end
