--C/C/C Rock Armor of Defense
function c511002384.initial_effect(c)
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	-- ATK
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002384.atkcon)
	e1:SetCost(c511002384.atkcost)
	e1:SetTarget(c511002384.atktg)
	e1:SetOperation(c511002384.atkop)
	c:RegisterEffect(e1)
	--Disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511002384.disop)
	c:RegisterEffect(e2)
end
function c511002384.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511002384.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002384.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH) and c:GetDefense()>0
end
function c511002384.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002384.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511002384.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c511002384.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local def=0
		local tc=g:GetFirst()
		while tc do
			local cdef=tc:GetDefense()
			if cdef<0 then cdef=0 end
			def=def+cdef
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(def/2)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c511002384.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc and tc:IsAttribute(ATTRIBUTE_EARTH) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x57a0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x57a0000)
		tc:RegisterEffect(e2)
	end
end
