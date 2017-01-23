--Synchro Overlimit
--  By Shad3

local scard=c511005038

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(scard.cd)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.syn_fil(c,p)
	return c:IsOnField() and c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsControler(p)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
	return scard.syn_fil(Duel.GetAttacker(),tp)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsOnField() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e2:SetOperation(scard.des_op)
		tc:RegisterEffect(e2)
	end
end

function scard.des_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end