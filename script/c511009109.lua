--Shura the Conqueror Star
function c511009109.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,511002013,c511009109.ffilter,1,true,true)
	
	--half atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetValue(0)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511009109.atkcon)
	e5:SetOperation(c511009109.atkop)
	c:RegisterEffect(e5)
end

function c511009109.ffilter(c)
	return c:IsRace(RACE_WARRIOR) and c:GetLevel()>=5
end

function c511009109.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:GetControler()~=d:GetControler() and (a==e:GetHandler() or d==e:GetHandler())
end
function c511009109.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsFaceup() and a:IsRelateToBattle() and d:IsFaceup() and d:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(a:GetLevel()*200)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(d:GetLevel()*200)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		d:RegisterEffect(e2)
	end
end
