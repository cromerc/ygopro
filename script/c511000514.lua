--Number 84: Pain Gainer
function c511000514.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,11,2,c511000514.ovfilter,aux.Stringid(511000514,0),3,c511000514.xyzop)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511000514.damop)
	c:RegisterEffect(e1)
	--gain atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000514,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000514.atkcon)
	e2:SetCost(c511000514.atkcost)
	e2:SetOperation(c511000514.atkop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511000514.indes)
	c:RegisterEffect(e3)
	if not c511000514.global_check then
		c511000514.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511000514.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511000514.xyz_number=84
function c511000514.cfilter(c)
	return c:IsSetCard(0x95) and c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c511000514.ovfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT) and c:IsSetCard(0x48) and c:GetCode()~=511000514
end
function c511000514.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000514.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c511000514.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c511000514.damop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp then
		Duel.Damage(1-tp,300,REASON_EFFECT)
	end
end
function c511000514.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511000514.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000514.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(ev)
		c:RegisterEffect(e1)
	end
end
function c511000514.indes(e,c)
	return not c:IsSetCard(0x48)
end