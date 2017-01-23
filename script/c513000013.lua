--スカーレッド・ノヴァ・ドラゴン
function c513000013.initial_effect(c)
	--synchro summon
	c513000013.tuner_filter=function(mc) return true end
	c513000013.nontuner_filter=function(mc) return mc and mc:IsCode(70902743) end
	c513000013.minntct=1
	c513000013.maxntct=1
	c513000013.sync=true
	c513000013.dobtun=true
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c513000013.syncon)
	e1:SetOperation(c513000013.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c513000013.atkval)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(c513000013.indval)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(24696097,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c513000013.bancon)
	e4:SetTarget(c513000013.bantg)
	e4:SetOperation(c513000013.banop)
	c:RegisterEffect(e4)
	--Return
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(24696097,3))
	e5:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCountLimit(1)
	e5:SetTarget(c513000013.rettg)
	e5:SetOperation(c513000013.retop)
	c:RegisterEffect(e5)
end
function c513000013.matfilter1(c,syncard)
	return c:IsType(TYPE_TUNER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanBeSynchroMaterial(syncard)
end
function c513000013.matfilter2(c,syncard)
	return c:IsFaceup() and c:IsCode(70902743) and c:IsCanBeSynchroMaterial(syncard)
end
function c513000013.synfilter1(c,syncard,lv,g1,g2,g3)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local f1=c.tuner_filter
	if c:IsHasEffect(55863245) then
		return g3:IsExists(c513000013.synfilter2,1,c,syncard,lv-tlv,g2,f1,c)
	else
		return g1:IsExists(c513000013.synfilter2,1,c,syncard,lv-tlv,g2,f1,c)
	end
end
function c513000013.synfilter2(c,syncard,lv,g2,f1,tuner1)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local f2=c.tuner_filter
	if f1 and not f1(c) then return false end
	if f2 and not f2(tuner1) then return false end
	return g2:IsExists(c513000013.synfilter3,1,nil,syncard,lv-tlv,f1,f2)
end
function c513000013.synfilter3(c,syncard,lv,f1,f2)
	local mlv=c:GetSynchroLevel(syncard)
	local lv1=bit.band(mlv,0xffff)
	local lv2=bit.rshift(mlv,16)
	return (lv1==lv or lv2==lv) and (not f1 or f1(c)) and (not f2 or f2(c))
end
function c513000013.syncon(e,c,tuner,mg)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-2 then return false end
	local g1=nil
	local g2=nil
	local g3=nil
	if mg then
		g1=mg:Filter(c513000013.matfilter1,nil,c)
		g2=mg:Filter(c513000013.matfilter2,nil,c)
		g3=mg:Filter(c513000013.matfilter1,nil,c)
	else
		g1=Duel.GetMatchingGroup(c513000013.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c513000013.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g3=Duel.GetMatchingGroup(c513000013.matfilter1,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		local tlv=tuner:GetSynchroLevel(c)
		if lv-tlv<=0 then return false end
		local f1=tuner.tuner_filter
		if not pe then
			return g1:IsExists(c513000013.synfilter2,1,tuner,c,lv-tlv,g2,f1,tuner)
		else
			return c513000013.synfilter2(pe:GetOwner(),c,lv-tlv,g2,f1,tuner)
		end
	end
	if not pe then
		return g1:IsExists(c513000013.synfilter1,1,nil,c,lv,g1,g2,g3)
	else
		return c513000013.synfilter1(pe:GetOwner(),c,lv,g1,g2)
	end
end
function c513000013.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner,mg)
	local g=Group.CreateGroup()
	local g1=nil
	local g2=nil
	local g3=nil
	if mg then
		g1=mg:Filter(c513000013.matfilter1,nil,c)
		g2=mg:Filter(c513000013.matfilter2,nil,c)
		g3=mg:Filter(c513000013.matfilter1,nil,c)
	else
		g1=Duel.GetMatchingGroup(c513000013.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c513000013.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g3=Duel.GetMatchingGroup(c513000013.matfilter1,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		g:AddCard(tuner)
		local lv1=tuner:GetSynchroLevel(c)
		local f1=tuner.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner2=nil
		if not pe then
			local t2=g1:FilterSelect(tp,c513000013.synfilter2,1,1,tuner,c,lv-lv1,g2,f1,tuner)
			tuner2=t2:GetFirst()
		else
			tuner2=pe:GetOwner()
			Group.FromCards(tuner2):Select(tp,1,1,nil)
		end
		g:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m3=g2:FilterSelect(tp,c513000013.synfilter3,1,1,nil,c,lv-lv1-lv2,f1,f2)
		g:Merge(m3)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner1=nil
		if not pe then
			local t1=g1:FilterSelect(tp,c513000013.synfilter1,1,1,nil,c,lv,g1,g2,g3)
			tuner1=t1:GetFirst()
		else
			tuner1=pe:GetOwner()
			Group.FromCards(tuner1):Select(tp,1,1,nil)
		end
		g:AddCard(tuner1)
		local lv1=tuner1:GetSynchroLevel(c)
		local f1=tuner1.tuner_filter
		local t2=nil
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		if tuner1:IsHasEffect(55863245) then
			t2=g3:FilterSelect(tp,c513000013.synfilter2,1,1,tuner1,c,lv-lv1,g2,f1,tuner1)
		else
			t2=g1:FilterSelect(tp,c513000013.synfilter2,1,1,tuner1,c,lv-lv1,g2,f1,tuner1)
		end
		local tuner2=t2:GetFirst()
		g:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m3=g2:FilterSelect(tp,c513000013.synfilter3,1,1,nil,c,lv-lv1-lv2,f1,f2)
		g:Merge(m3)
	end
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c513000013.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_TUNER)*500
end
function c513000013.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
function c513000013.bancon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c513000013.bantg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c513000013.banop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Remove(c,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)>0 then
		c:RegisterFlagEffect(513000013,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		if Duel.GetAttacker() and Duel.SelectYesNo(tp,94) then Duel.NegateAttack()
		else
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCountLimit(1)
		e1:SetOperation(c513000013.negop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		end
	end
end
function c513000013.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:GetFlagEffect(513000013)>0 end
end
function c513000013.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.ReturnToField(e:GetHandler())
	end
end
function c513000013.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
