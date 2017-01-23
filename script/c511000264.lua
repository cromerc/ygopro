--Polar God Sacred Emperor Odin
function c511000264.initial_effect(c)
	--Synchro Summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,511000264)
	--Influence of Rune
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000264,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000264.con)
	e1:SetOperation(c511000264.op)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c511000264.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(93483212,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000264.spcon)
	e3:SetTarget(c511000264.sptg)
	e3:SetOperation(c511000264.spop)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(93483212,2))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c511000264.drcon)
	e4:SetTarget(c511000264.drtg)
	e4:SetOperation(c511000264.drop)
	c:RegisterEffect(e4)
end
function c511000264.con(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():GetFlagEffect(511000263)>0
end
function c511000264.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_SOLVING)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
		e1:SetCondition(c511000264.imcon)
		e1:SetOperation(c511000264.imop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC_G)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c511000264.discon)
		e1:SetOperation(c511000264.disop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(511000263,RESET_EVENT+0x1fe0000,0,0)
	end
end
function c511000264.cfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_DEVINE)
end
function c511000264.imcon(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_MONSTER) or not Duel.IsChainDisablable(ev) then return false end
	if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsExists(c511000264.cfilter,1,nil) then return true end
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_RELEASE)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_CONTROL)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DISABLE)
	if ex and tg~=nil and tc+tg:FilterCount(c511000264.cfilter,nil)-tg:GetCount()>0 then
		return true
	end
	return false
end
function c511000264.imop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(799183,0)) then
		Duel.NegateEffect(ev)
	end
end
function c511000264.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local pos=c:GetPreviousPosition()
	if c:IsReason(REASON_BATTLE) then pos=c:GetBattlePosition() end
	if c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and bit.band(pos,POS_FACEUP)~=0 then
		c:RegisterFlagEffect(511000264,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511000264.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000264)~=0
end
function c511000264.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,1,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000264.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),1,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000264.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c511000264.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511000264.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c511000264.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card) and not c:IsDisabled()
end
function c511000264.disfilter(c)
	local eqg=c:GetEquipGroup():Filter(c511000264.dischk,nil)
	local tgg=Duel.GetMatchingGroup(c511000264.tgg,0,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	return c:IsRace(RACE_DEVINE) and eqg:GetCount()>0
end
function c511000264.dischk(c)
	return not c:IsDisabled()
end
function c511000264.discon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c511000264.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c511000264.disop(e,tp,eg,ep,ev,re,r,rp,c,og)
	Duel.Hint(HINT_CARD,0,511000264)
	local g=Duel.GetMatchingGroup(c511000264.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		local eqg=tc:GetEquipGroup():Filter(c511000264.dischk,nil)
		local tgg=Duel.GetMatchingGroup(c511000264.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tc)
		sg:Merge(eqg)
		sg:Merge(tgg)
		tc=g:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local dg=sg:Select(tp,1,99,nil)
	local dc=dg:GetFirst()
	while dc do
		Duel.NegateRelatedChain(dc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		dc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		dc:RegisterEffect(e2)
		if dc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			dc:RegisterEffect(e3)
		end
		dc=dg:GetNext()
	end
	Duel.BreakEffect()
	return
end
