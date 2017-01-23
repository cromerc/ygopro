--Gorlag
function c511000265.initial_effect(c)
	--check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BATTLED)
	e1:SetOperation(c511000265.checkop)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	e1:SetLabelObject(g)
	g:KeepAlive()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetOperation(c511000265.checkop2)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24104865,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000265.spcon)
	e3:SetTarget(c511000265.sptg)
	e3:SetOperation(c511000265.spop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c511000265.desop)
	c:RegisterEffect(e4)
	--Gain ATK for Each Fire Monster
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c511000265.val)
	c:RegisterEffect(e5)
	--Cannot Attack Directly
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
end
function c511000265.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_FIRE)
end
function c511000265.val(e,c)
	return Duel.GetMatchingGroupCount(c511000265.cfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
function c511000265.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local t=Duel.GetAttackTarget()
	if t and t~=c then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511000265.checkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabelObject():GetLabel()==0 then return end
	local t=c:GetBattleTarget()
	local g=e:GetLabelObject():GetLabelObject()
	if c:GetFieldID()~=e:GetLabel() then
		g:Clear()
		e:SetLabel(c:GetFieldID())
	end
	if aux.bdgcon(e,tp,eg,ep,ev,re,r,rp) then
		g:AddCard(t)
		t:RegisterFlagEffect(51100265,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
	end
end
function c511000265.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFieldID()==e:GetLabelObject():GetLabel()
end
function c511000265.filter(c,e,tp)
	return c:GetFlagEffect(51100265)~=0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000265.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject():GetLabelObject():GetLabelObject()
	if chk==0 then return g:IsExists(c511000265.filter,1,nil,e,tp) end
	local dg=g:Filter(c511000265.filter,nil,e,tp)
	g:Clear()
	Duel.SetTargetCard(dg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,dg,dg:GetCount(),0,0)
end
function c511000265.sfilter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000265.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(c511000265.sfilter,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if sg:GetCount()>ft then sg=sg:Select(tp,ft,ft,nil) end
	local tc=sg:GetFirst()
	local c=e:GetHandler()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		tc:RegisterFlagEffect(51100265,RESET_EVENT+0x1fe0000,0,0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(ATTRIBUTE_FIRE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3,true)
		c:CreateRelation(tc,RESET_EVENT+0x1020000)
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
end
function c511000265.desfilter(c,rc)
	return c:GetFlagEffect(51100265)~=0 and rc:IsRelateToCard(c)
end
function c511000265.desop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c511000265.desfilter,tp,LOCATION_MZONE,0,nil,e:GetHandler())
	Duel.Destroy(dg,REASON_EFFECT)
end
