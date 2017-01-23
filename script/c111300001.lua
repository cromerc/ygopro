--革命－トリック・バトル
function c111300001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c111300001.preatkop)
	c:RegisterEffect(e2)
	local f=Card.GetReasonCard
	Card.GetReasonCard=function(c)
		if c:GetFlagEffect(111300001)>0 then
			local a=Duel.GetAttacker()
			local d=Duel.GetAttackTarget()
			if a==c then return d end
			if d==c then return a end
			return nil
		end
		return f(c)
	end
end
function c111300001.preatkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	if not a:IsPosition(POS_FACEUP_ATTACK) or not d:IsPosition(POS_FACEUP_ATTACK) then return end
	if a:GetAttack()==d:GetAttack() then return end
	if d:GetAttack()>a:GetAttack() then
		a,d=d,a
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	d:RegisterEffect(e1)
	local e2=Effect.CreateEffect(d)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetOperation(c111300001.op)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	d:RegisterEffect(e2)
end
function c111300001.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==1 then return end
	if Duel.Destroy(bc,REASON_BATTLE)==0 then
		Duel.SendtoGrave(bc,REASON_BATTLE)
	end
	bc:SetStatus(STATUS_BATTLE_DESTROYED,true)
	Duel.RaiseEvent(c,EVENT_BATTLE_DESTROYING,e,REASON_BATTLE,c:GetControler(),c:GetControler(),0)
	c:RegisterFlagEffect(111300001,RESET_PHASE+PHASE_DAMAGE,0,0)
	bc:RegisterFlagEffect(111300001,RESET_PHASE+PHASE_DAMAGE,0,0)
end
