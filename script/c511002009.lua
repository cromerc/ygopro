--Moonlight Panther Dancer
function c511002009.initial_effect(c)
	--fustion material
	aux.AddFusionProcCodeFun(c,51777272,aux.FilterBoolFunction(Card.IsSetCard,0xdf),1,true,true)
	c:EnableReviveLimit()
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(9999)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c511002009.unop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_DAMAGE_CALCULATING)
	e3:SetCondition(c511002009.indescon)
	e3:SetOperation(c511002009.indesop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetTarget(c511002009.valtg)
	e4:SetValue(c511002009.vala)
	c:RegisterEffect(e4)
	--atk up
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetCode(EVENT_BATTLE_DESTROYING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511002009.atkcon)
	e5:SetOperation(c511002009.atkop)
	c:RegisterEffect(e5)
	--indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetValue(c511002009.indval)
	c:RegisterEffect(e6)
end
function c511002009.unop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:GetFlagEffect(511002009)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(511002009,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
	end
	if bc then
		if bc:GetFlagEffect(511002007)>0 then
			bc:RegisterFlagEffect(511002008,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
		else
			bc:RegisterFlagEffect(511002007,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
		end
	end
end
function c511002009.valtg(e,c)
	return c:GetFlagEffect(511002008)>0
end
function c511002009.vala(e,c)
	return c==e:GetHandler()
end
function c511002009.indescon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:GetFlagEffect(511002007)==0
end
function c511002009.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsRelateToBattle() and e:GetHandler():IsFaceup()
end
function c511002009.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c511002009.indesop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	bc:RegisterEffect(e1,true)
end
function c511002009.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end
