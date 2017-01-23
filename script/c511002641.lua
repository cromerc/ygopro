--神機王ウル
function c511002641.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c511002641.vala)
	c:RegisterEffect(e1)
	--pos Change
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetOperation(c511002641.regop)
	c:RegisterEffect(e3)
	--attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(9999)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e5:SetCondition(c511002641.dircon)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_ATTACK)
	e6:SetCondition(c511002641.atkcon2)
	c:RegisterEffect(e6)
end
function c511002641.vala(e,c)
	local ca=e:GetHandler()
	return ca:GetFlagEffect(511002641)>0 
		and (c:GetLevel()>ca:GetLevel()-ca:GetFlagEffect(511002641) or c:IsFacedown())
end
function c511002641.regop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d then
		local i=0
		local lv=d:GetLevel()
		while i<lv do
			e:GetHandler():RegisterFlagEffect(511002641,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,0)
			i=i+1
		end
	end
end
function c511002641.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c511002641.atkcon2(e)
	return e:GetHandler():IsDirectAttacked()
end
