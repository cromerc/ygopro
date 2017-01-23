--Shadow Guardsmen
--fixed by MLD
function c511009030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c511009030.condition)
	e1:SetTarget(c511009030.target)
	e1:SetOperation(c511009030.activate)
	c:RegisterEffect(e1)
end
function c511009030.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511009030.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonMonster(tp,511009031,0,0x4011,1,1,1,RACE_WARRIOR,ATTRIBUTE_DARK) 
		and ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct end
	local ct=Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c511009030.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511009031,0,0x4011,1,1,1,RACE_WARRIOR,ATTRIBUTE_DARK) then return end
	local fid=e:GetHandler():GetFieldID()
	local g=Group.CreateGroup()
	for i=1,ct do
		local token=Duel.CreateToken(tp,511009031)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		token:RegisterFlagEffect(51109030,RESET_EVENT+0x1fe0000,0,1,fid)
		g:AddCard(token)
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(g)
	e1:SetCondition(c511009030.descon)
	e1:SetOperation(c511009030.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511009030.desfilter(c,fid)
	return c:GetFlagEffectLabel(51109030)==fid
end
function c511009030.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511009030.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511009030.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511009030.desfilter,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end
