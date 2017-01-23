--Black Rose Seed
function c511002216.initial_effect(c)
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511002216.condition)
	e1:SetTarget(c511002216.target)
	e1:SetOperation(c511002216.activate)
	c:RegisterEffect(e1)
end
c511002216.collection={
	[49674183]=true;[96470883]=true;[31986288]=true;[41160533]=true;[51085303]=true;
	[41201555]=true;[75252099]=true;[58569561]=true;[96385345]=true;[17720747]=true;
	[98884569]=true;[23087070]=true;[1557341]=true;[12469386]=true;[2986553]=true;
	[51852507]=true;[44125452]=true;[61049315]=true;[79531196]=true;[89252157]=true;
	[32485271]=true;[33698022]=true;[73580471]=true;[4290468]=true;[25090294]=true;
	[45247637]=true;[71645243]=true;[73580471]=true;[4290468]=true;[25090294]=true;
}
function c511002216.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d==nil then return end
	if (a:IsSetCard(0x218) or c511002216.collection[a:GetCode()]) and not (d:IsSetCard(0x218) or c511002216.collection[d:GetCode()]) 
		and a:IsRelateToBattle() then
		e:SetLabelObject(a)
		return true
	end
	if not (a:IsSetCard(0x218) or c511002216.collection[a:GetCode()]) and (d:IsSetCard(0x218) or c511002216.collection[d:GetCode()]) 
		and d:IsRelateToBattle() then
		e:SetLabelObject(d)
		return true
	end
	return false
end
function c511002216.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return true end
	Duel.SetTargetCard(tc)
end
function c511002216.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(800)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	tc:RegisterEffect(e2)
end
