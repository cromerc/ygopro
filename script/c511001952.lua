--Ultimitl Bishbalkin the Ultimate Legendary God
function c511001952.initial_effect(c)
	--level 0
	c:SetStatus(STATUS_NO_LEVEL,true)
	--dark synchro summon
	c:EnableReviveLimit()
	c511001952.tuner_filter=function(mc) return mc and mc:IsSetCard(0x301) end
	c511001952.nontuner_filter=function(mc) return true end
	c511001952.minntct=1
	c511001952.maxntct=1
	c511001952.sync=true
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511001952.syncon)
	e1:SetOperation(c511001952.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511001952.val)
	c:RegisterEffect(e2)
	--Token
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511001952.sptg)
	e3:SetOperation(c511001952.spop)
	c:RegisterEffect(e3)	
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c511001952.desreptg)
	e4:SetOperation(c511001952.desrepop)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(29146185,1))
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(511001952)
	e5:SetTarget(c511001952.destg)
	e5:SetOperation(c511001952.desop)
	c:RegisterEffect(e5)
	--add setcode
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EFFECT_ADD_SETCODE)
	e6:SetValue(0x301)
	c:RegisterEffect(e6)
end
function c511001952.tmatfilter(c,syncard)
	return c:IsSetCard(0x301) and c:IsType(TYPE_TUNER) and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c511001952.ntmatfilter(c,syncard)	
	return c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard) and not c:IsType(TYPE_TUNER)
end
function c511001952.synfilter1(c,lv,tuner,syncard)
	local tlv=c:GetSynchroLevel(syncard)
	if c:GetFlagEffect(100000147)==0 then
		return c:IsLevelAbove(8) and tuner:IsExists(c511001952.synfilter2,1,nil,tlv,lv+tlv,syncard)
	else
		return tuner:IsExists(c511001952.synfilter2,1,nil,lv-tlv,syncard)
	end	
end
function c511001952.synfilter2(c,lv,lv2,syncard)
	return c:GetSynchroLevel(syncard)==lv or c:GetSynchroLevel(syncard)==lv2
end
function c511001952.syncon(e,c,tuner)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return false end
	local tuner=Duel.GetMatchingGroup(c511001952.tmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nontuner=Duel.GetMatchingGroup(c511001952.ntmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	return nontuner:IsExists(c511001952.synfilter1,1,nil,12,tuner,c)
end
function c511001952.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local g=Group.CreateGroup()
	local tun=Duel.GetMatchingGroup(c511001952.tmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nont=Duel.GetMatchingGroup(c511001952.ntmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local nontmat=nont:FilterSelect(tp,c511001952.synfilter1,1,1,nil,12,tun,c)
	local mat1=nontmat:GetFirst()
	g:AddCard(mat1)
	local lv1=mat1:GetSynchroLevel(c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local t
	if mat1:GetFlagEffect(100000147)==0 then
		t=tun:FilterSelect(tp,c511001952.synfilter2,1,1,nil,12+lv1,lv1,c)
	else
		t=tun:FilterSelect(tp,c511001952.synfilter2,1,1,nil,12-lv1,c)
	end
	g:Merge(t)
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c511001952.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,LOCATION_MZONE)*1000
end
function c511001952.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,90884404,0,0x4011,100,0,1,RACE_FIEND,ATTRIBUTE_DARK)) 
		or (Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(1-tp,90884404,0,0x4011,100,0,1,RACE_FIEND,ATTRIBUTE_DARK)) end
	local ft=(Duel.GetLocationCount(tp,LOCATION_MZONE)+Duel.GetLocationCount(1-tp,LOCATION_MZONE))
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
end
function c511001952.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,90884404,0,0x4011,100,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	for i=1,ft do
		local token=Duel.CreateToken(tp,90884404)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(100)
		e1:SetReset(RESET_EVENT+0xfe0000)
		token:RegisterEffect(e1)
	end
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft2>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft2=1 end
	if ft2<=0 or not Duel.IsPlayerCanSpecialSummonMonster(1-tp,90884404,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	for i=1,ft2 do
		local token=Duel.CreateToken(tp,90884404)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(100)
		e1:SetReset(RESET_EVENT+0xfe0000)
		token:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function c511001952.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	if Duel.SelectYesNo(tp,aux.Stringid(511001952,0)) then return true
	else return false end
end
function c511001952.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),511001952,re,r,rp,0,0)
end
function c511001952.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*200)
end
function c511001952.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*200,REASON_EFFECT)
	end
end
