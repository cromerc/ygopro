--Dimension Magic
--Scripted by Edo9300
function c511004004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCondition(c511004004.condition)
	e1:SetTarget(c511004004.target)
	e1:SetOperation(c511004004.activate)
	c:RegisterEffect(e1)
end
function c511004004.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c511004004.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511004004.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511004004.filter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511004004.rfilter(c,fid)
	return c:IsReleasableByEffect() and c:GetFieldID()~=fid
end
function c511004004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(c511004004.cfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			if Duel.CheckReleaseGroup(tp,Card.IsReleasableByEffect,2,tc) then
				ch=1
				tc=nil
			else
				ch=0
				tc=g:GetNext()
			end
		end
	end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and ch==1
		and Duel.IsExistingMatchingCard(c511004004.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	local g1=Duel.GetMatchingGroup(c511004004.cfilter,tp,LOCATION_MZONE,0,nil)
	local ct=g1:GetCount()
	if ct>2 then
		g=Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,2,2,nil)
	elseif ct==1 then
		g=Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,2,2,g1:GetFirst())
	elseif ct==2 then
		g=Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,1,1,nil)
		g1=Duel.GetMatchingGroup(c511004004.cfilter,tp,LOCATION_MZONE,0,g:GetFirst())
		if g1:GetCount()==2 then
			g:AddCard(Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,1,1,g:GetFirst()):GetFirst())
		else
			g:AddCard(Duel.SelectReleaseGroup(tp,c511004004.rfilter,1,1,g:GetFirst(),g1:GetFirst():GetFieldID()):GetFirst())
		end
	end
	e:SetLabelObject(g)
	g:KeepAlive()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511004004.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetCount()==2 then
		if Duel.Release(g,REASON_EFFECT)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c511004004.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if sg:GetCount()==0 then return end
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		if Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_MZONE,0,2,nil,RACE_SPELLCASTER) 
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) then
			local sg=Duel.SelectMatchingCard(tp,Card.IsRace,tp,LOCATION_MZONE,0,2,2,nil,RACE_SPELLCASTER)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
			local fid=e:GetHandler():GetFieldID()
			sg:GetFirst():RegisterFlagEffect(511004004,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
			sg:GetNext():RegisterFlagEffect(511004004,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
			sg:KeepAlive()
			Duel.HintSelection(sg)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCountLimit(1)
			e1:SetLabel(fid)
			e1:SetLabelObject(sg)
			e1:SetCondition(c511004004.rmcon)
			e1:SetOperation(c511004004.rmop)
			Duel.RegisterEffect(e1,tp)
			Duel.HintSelection(dg)
			Duel.BreakEffect()
			Duel.Destroy(dg,REASON_BATTLE)
		end
	end
end

function c511004004.rmfilter(c,fid)
	return c:GetFlagEffectLabel(511004004)==fid
end
function c511004004.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511004004.rmfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511004004.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511004004.rmfilter,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end
