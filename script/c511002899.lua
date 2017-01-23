--Battle of Sleeping Spirits
function c511002899.initial_effect(c)
	--synchro effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_END)
	e1:SetCondition(c511002899.condition)
	e1:SetTarget(c511002899.target)
	e1:SetOperation(c511002899.activate)
	c:RegisterEffect(e1)
end
function c511002899.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511002899.filter(c,e,tp,tid)
	return bit.band(c:GetReason(),REASON_BATTLE)~=0 and c:GetTurnID()==tid and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c511002899.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002899.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tid) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002899.activate(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	local g1=Group.CreateGroup()
	local g2=Group.CreateGroup()
	local fid=e:GetHandler():GetFieldID()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002899.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tid) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g1=Duel.SelectMatchingCard(tp,c511002899.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,tid)
		Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		g1:GetFirst():RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		g1:GetFirst():RegisterEffect(e2,true)
		g1:GetFirst():RegisterFlagEffect(51102899,RESET_EVENT+0x1fe0000,0,1,fid)
	end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002899.filter,1-tp,LOCATION_GRAVE,0,1,nil,e,1-tp,tid)
		and Duel.SelectYesNo(1-tp,aux.Stringid(511000631,1)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		g2=Duel.SelectMatchingCard(1-tp,c511002899.filter,1-tp,LOCATION_GRAVE,0,1,1,nil,e,1-tp,tid)
		Duel.SpecialSummonStep(g2:GetFirst(),0,1-tp,1-tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		g2:GetFirst():RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		g2:GetFirst():RegisterEffect(e2,true)
		g2:GetFirst():RegisterFlagEffect(51102899,RESET_EVENT+0x1fe0000,0,1,fid)
	end
	Duel.SpecialSummonComplete()
	g1:Merge(g2)
	g1:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(g1)
	e1:SetCondition(c511002899.descon)
	e1:SetOperation(c511002899.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511002899.desfilter(c,fid)
	return c:GetFlagEffectLabel(51102899)==fid
end
function c511002899.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511002899.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511002899.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511002899.desfilter,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end
