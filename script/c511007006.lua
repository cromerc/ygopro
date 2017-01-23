--coded by Lyris
--Flash Fang
--fixed by MLD
function c511007006.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511007006.target)
	e1:SetOperation(c511007006.activate)
	c:RegisterEffect(e1)
end
c511007006.collection={
	[13429800]=true;[34290067]=true;[10532969]=true;[71923655]=true;[32393580]=true;
	[810000016]=true;[20358953]=true;[37798171]=true;[70101178]=true;[23536866]=true;
	[7500772]=true;[511001410]=true;[69155991]=true;[37792478]=true;[17201174]=true;
	[44223284]=true;[70655556]=true;[63193879]=true;[25484449]=true;[810000026]=true;
	[17643265]=true;[64319467]=true;[810000030]=true;[810000008]=true;[20838380]=true;
	[87047161]=true;[80727036]=true;[28593363]=true;[50449881]=true;[49221191]=true;
	[65676461]=true;[440556]=true;[511001273]=true;[31320433]=true;[5014629]=true;
	[14306092]=true;[84224627]=true;[511001163]=true;[511001169]=true;[511001858]=true;
}
function c511007006.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x321) or c511007006.collection[c:GetCode()])
end
function c511007006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511007006.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511007006.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511007006.filter,tp,LOCATION_MZONE,0,nil)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(51107006,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLE_DAMAGE)
		e2:SetOperation(c511007006.regop)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
	sg:KeepAlive()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetReset(RESET_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetLabel(fid)
	e2:SetLabelObject(sg)
	e2:SetCondition(c511007006.descon)
	e2:SetOperation(c511007006.desop)
	Duel.RegisterEffect(e2,tp)
end
function c511007006.regop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp and Duel.GetAttackTarget()==nil then
		local c=e:GetHandler()
		c:SetFlagEffectLabel(51107006,c:GetFlagEffectLabel(51107006)+ev)
	end
end
function c511007006.desfilter(c,fid)
	return c:GetFlagEffectLabel(51107006)-fid>0
end
function c511007006.desopfilter(c,dam)
	return c:GetAttack()<dam
end
function c511007006.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local fid=e:GetLabel()
	local dg=g:Filter(c511007006.desfilter,nil,fid)
	if dg:GetCount()~=0 then
		local dam=0
		local tc=dg:GetFirst()
		while tc do
			dam=dam+(tc:GetFlagEffectLabel(51107006)-fid)
			tc=dg:GetNext()
		end
		return Duel.IsExistingMatchingCard(c511007006.desopfilter,tp,0,LOCATION_MZONE,1,nil,dam)
	else
		g:DeleteGroup()
		e:Reset()
		return false
	end
end
function c511007006.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local fid=e:GetLabel()
	local dg=g:Filter(c511007006.desfilter,nil,fid)
	g:DeleteGroup()
	local dam=0
	local tc=dg:GetFirst()
	while tc do
		dam=dam+(tc:GetFlagEffectLabel(51107006)-fid)
		tc=dg:GetNext()
	end
	local sg=Duel.GetMatchingGroup(c511007006.desopfilter,tp,0,LOCATION_MZONE,nil,dam)
	Duel.Destroy(sg,REASON_EFFECT)
end
