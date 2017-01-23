--Raid Raptors - Rise Falcon
function c511000674.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),4,3)
	c:EnableReviveLimit()	
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c511000674.atkfilter)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetDescription(aux.Stringid(511000674,0))
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511000674.cost)
	e2:SetTarget(c511000674.tg)
	e2:SetOperation(c511000674.op)
	c:RegisterEffect(e2)
	--atklimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c511000674.bttg)
	e3:SetValue(c511000674.btval)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e4)
end
function c511000674.atkfilter(e,c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511000674.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000674.filter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511000674.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000674.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c511000674.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511000674.filter,tp,0,LOCATION_MZONE,nil)
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
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511000674.bttg(e,c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=SUMMON_TYPE_SPECIAL
end
function c511000674.btval(e,c)
	return c==e:GetHandler()
end
