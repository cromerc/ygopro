--革命－トリック・バトル
function c111300001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--copy	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)	
	e2:SetOperation(c111300001.operation)
	c:RegisterEffect(e2)
end
function c111300001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local wg=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local wbc=wg:GetFirst()
	while wbc do
		if wbc:IsAttackPos()  and wbc:GetFlagEffect(111300001)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_INITIAL)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLED)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c111300001.con)
		e1:SetOperation(c111300001.op)
		e1:SetReset(RESET_EVENT+0x1fe0000+EVENT_ADJUST,1)
		wbc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(c111300001.indes)
		e1:SetReset(RESET_EVENT+0x1fe0000+EVENT_ADJUST,1)
		wbc:RegisterEffect(e2)
		c:RegisterFlagEffect(111300001,RESET_EVENT+0x1fe0000+EVENT_ADJUST,0,1) 	
		end	
		wbc=wg:GetNext()
	end		
end
function c111300001.indes(e,c)
	return c:GetAttack()>e:GetHandler():GetAttack() and c:GetPosition()==POS_FACEUP_ATTACK 
end
function c111300001.con(e)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc then return end
	local atk=bc:GetAttack()
	local bct=0
	bct=c:GetAttack()
	return bc:IsRelateToBattle() and bc:GetPosition()==POS_FACEUP_ATTACK 
	 and atk>bct and not c:IsStatus(STATUS_BATTLE_DESTROYED) and c:GetPosition()==POS_FACEUP_ATTACK
end
function c111300001.op(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	Duel.Destroy(bc,REASON_BATTLE)
	bc:SetStatus(STATUS_BATTLE_DESTROYED,true)
end
