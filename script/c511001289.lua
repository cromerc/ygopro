--Moonlight Cat Dancer
function c511001289.initial_effect(c)
	--fustion material
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0xdf),2,true)
	c:EnableReviveLimit()
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001289,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511001289.cost)
	e1:SetOperation(c511001289.operation)
	c:RegisterEffect(e1)
end
function c511001289.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,e:GetHandler(),0xdf)
		and e:GetHandler():GetFlagEffect(511001289)==0 end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,e:GetHandler(),0xdf)
	Duel.Release(g,REASON_COST)
end
function c511001289.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:GetFlagEffect(511001289)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(9999)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511001289.unop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EVENT_DAMAGE_CALCULATING)
		e3:SetCondition(c511001289.indescon)
		e3:SetOperation(c511001289.indesop)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetRange(LOCATION_MZONE)
		e4:SetTargetRange(0,LOCATION_MZONE)
		e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e4:SetTarget(c511001289.valtg)
		e4:SetValue(c511001289.vala)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e4)
		c:RegisterFlagEffect(511001289,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511001289.unop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:GetFlagEffect(511001288)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(511001288,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
	end
	if bc then
		if bc:GetFlagEffect(511001286)>0 then
			bc:RegisterFlagEffect(511001287,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
		else
			bc:RegisterFlagEffect(511001286,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
		end
	end
end
function c511001289.valtg(e,c)
	return c:GetFlagEffect(511001287)>0
end
function c511001289.vala(e,c)
	return c==e:GetHandler()
end
function c511001289.indescon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:GetFlagEffect(511001286)==0
end
function c511001289.indesop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	bc:RegisterEffect(e1,true)
end
