--Hot Red Dragon Archfiend King Calamity
function c511001603.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c511001603.syncon)
	e0:SetOperation(c511001603.synop)
	e0:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e0)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53981499,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c511001603.damcon)
	e1:SetTarget(c511001603.damtg)
	e1:SetOperation(c511001603.damop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001603,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetTarget(c511001603.sptg)
	e2:SetOperation(c511001603.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCondition(c511001603.descon)
	e3:SetOperation(c511001603.desop)
	c:RegisterEffect(e3)
end
function c511001603.matfilter1(c,syncard)
	return c:IsType(TYPE_TUNER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanBeSynchroMaterial(syncard)
end
function c511001603.matfilter2(c,syncard)
	return c:IsFaceup() and not c:IsType(TYPE_TUNER) and c:IsType(TYPE_SYNCHRO) and c:IsCanBeSynchroMaterial(syncard)
end
function c511001603.synfilter1(c,syncard,lv,g1,g2,g3)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local f1=c.tuner_filter
	if c:IsHasEffect(55863245) then
		return g3:IsExists(c511001603.synfilter2,1,c,syncard,lv-tlv,g2,f1,c)
	else
		return g1:IsExists(c511001603.synfilter2,1,c,syncard,lv-tlv,g2,f1,c)
	end
end
function c511001603.synfilter2(c,syncard,lv,g2,f1,tuner1)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local f2=c.tuner_filter
	if f1 and not f1(c) then return false end
	if f2 and not f2(tuner1) then return false end
	return g2:IsExists(c511001603.synfilter3,1,nil,syncard,lv-tlv,f1,f2)
end
function c511001603.synfilter3(c,syncard,lv,f1,f2)
	local mlv=c:GetSynchroLevel(syncard)
	local lv1=bit.band(mlv,0xffff)
	local lv2=bit.rshift(mlv,16)
	return (lv1==lv or lv2==lv) and (not f1 or f1(c)) and (not f2 or f2(c))
end
function c511001603.syncon(e,c,tuner,mg)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-2 then return false end
	local g1=nil
	local g2=nil
	local g3=nil
	if mg then
		g1=mg:Filter(c511001603.matfilter1,nil,c)
		g2=mg:Filter(c511001603.matfilter2,nil,c)
		g3=mg:Filter(c511001603.matfilter1,nil,c)
	else
		g1=Duel.GetMatchingGroup(c511001603.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c511001603.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g3=Duel.GetMatchingGroup(c511001603.matfilter1,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		local tlv=tuner:GetSynchroLevel(c)
		if lv-tlv<=0 then return false end
		local f1=tuner.tuner_filter
		if not pe then
			return g1:IsExists(c511001603.synfilter2,1,tuner,c,lv-tlv,g2,f1,tuner)
		else
			return c511001603.synfilter2(pe:GetOwner(),c,lv-tlv,g2,f1,tuner)
		end
	end
	if not pe then
		return g1:IsExists(c511001603.synfilter1,1,nil,c,lv,g1,g2,g3)
	else
		return c511001603.synfilter1(pe:GetOwner(),c,lv,g1,g2)
	end
end
function c511001603.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner,mg)
	local g=Group.CreateGroup()
	local g1=nil
	local g2=nil
	local g3=nil
	if mg then
		g1=mg:Filter(c511001603.matfilter1,nil,c)
		g2=mg:Filter(c511001603.matfilter2,nil,c)
		g3=mg:Filter(c511001603.matfilter1,nil,c)
	else
		g1=Duel.GetMatchingGroup(c511001603.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g2=Duel.GetMatchingGroup(c511001603.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		g3=Duel.GetMatchingGroup(c511001603.matfilter1,tp,LOCATION_MZONE+LOCATION_HAND,LOCATION_MZONE,nil,c)
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
			local t2=g1:FilterSelect(tp,c511001603.synfilter2,1,1,tuner,c,lv-lv1,g2,f1,tuner)
			tuner2=t2:GetFirst()
		else
			tuner2=pe:GetOwner()
			Group.FromCards(tuner2):Select(tp,1,1,nil)
		end
		g:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m3=g2:FilterSelect(tp,c511001603.synfilter3,1,1,nil,c,lv-lv1-lv2,f1,f2)
		g:Merge(m3)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner1=nil
		if not pe then
			local t1=g1:FilterSelect(tp,c511001603.synfilter1,1,1,nil,c,lv,g1,g2,g3)
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
			t2=g3:FilterSelect(tp,c511001603.synfilter2,1,1,tuner1,c,lv-lv1,g2,f1,tuner1)
		else
			t2=g1:FilterSelect(tp,c511001603.synfilter2,1,1,tuner1,c,lv-lv1,g2,f1,tuner1)
		end
		local tuner2=t2:GetFirst()
		g:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m3=g2:FilterSelect(tp,c511001603.synfilter3,1,1,nil,c,lv-lv1-lv2,f1,f2)
		g:Merge(m3)
	end
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c511001603.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsType(TYPE_MONSTER)
end
function c511001603.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local dam=bc:GetAttack()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001603.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511001603.filter(c,e,tp)
	return c:IsCode(39765958) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001603.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511001603.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001603.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then
		local ge=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local tc=ge:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			tc=ge:GetNext()
		end
	end
end
function c511001603.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d
end
function c511001603.desfilter(c,ca)
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and (not ca or ca==c)
end
function c511001603.desop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsStatus(STATUS_BATTLE_DESTROYED) or not d:IsStatus(STATUS_BATTLE_DESTROYED) then
		local g=Group.FromCards(a,d)
		if a:IsAttackPos() and d:IsAttackPos() then
			if a:GetAttack()==d:GetAttack()  then
				g=g:Filter(c511001603.desfilter,nil,nil)
			elseif a:GetAttack()<d:GetAttack() then
				g=g:Filter(c511001603.desfilter,nil,a)
			elseif a:GetAttack()>d:GetAttack() then
				g=g:Filter(c511001603.desfilter,nil,d)
			else
				g=Group.CreateGroup()
			end
		elseif a:IsAttackPos() and d:IsDefensePos() then
			if a:GetAttack()>d:GetDefense() then
				g=g:Filter(c511001603.desfilter,nil,d)
			else
				g=Group.CreateGroup()
			end
		else
			g=Group.CreateGroup()
		end
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e2)
			tc:SetStatus(STATUS_BATTLE_DESTROYED,true)
			tc=g:GetNext()
		end
		Duel.Destroy(g,REASON_BATTLE)
	end
end
