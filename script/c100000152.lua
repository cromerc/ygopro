--猿魔王 ゼーマン
function c100000152.initial_effect(c)
	--dark synchro summon
	c:EnableReviveLimit()
	c100000152.tuner_filter=function(mc) return mc and mc:IsSetCard(0x301) end
	c100000152.nontuner_filter=function(mc) return true end
	c100000152.minntct=1
	c100000152.maxntct=1
	c100000152.sync=true
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c100000152.syncon)
	e1:SetOperation(c100000152.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)			
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetOperation(c100000152.lmop)
	c:RegisterEffect(e2)
	--negate attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22858242,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c100000152.condition)
	e3:SetCost(c100000152.cost)
	e3:SetTarget(c100000152.target)
	e3:SetOperation(c100000152.activate)
	c:RegisterEffect(e3)
	--add setcode
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_SETCODE)
	e4:SetValue(0x301)
	c:RegisterEffect(e4)
end
function c100000152.tmatfilter(c,syncard)
	return c:IsSetCard(0x301) and c:IsType(TYPE_TUNER) and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c100000152.ntmatfilter(c,syncard)	
	return c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard) and not c:IsType(TYPE_TUNER)
end
function c100000152.synfilter1(c,lv,tuner,syncard)
	local tlv=c:GetSynchroLevel(syncard)
	if c:GetFlagEffect(100000147)==0 then	
		return tuner:IsExists(c100000152.synfilter2,1,nil,lv+tlv,syncard)
	else
		return tuner:IsExists(c100000152.synfilter2,1,nil,lv-tlv,syncard)
	end	
end
function c100000152.synfilter2(c,lv,syncard)
	return c:GetSynchroLevel(syncard)==lv
end
function c100000152.syncon(e,c,tuner)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return false end
	local tuner=Duel.GetMatchingGroup(c100000152.tmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nontuner=Duel.GetMatchingGroup(c100000152.ntmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	return nontuner:IsExists(c100000152.synfilter1,1,nil,7,tuner,c)
end
function c100000152.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local g=Group.CreateGroup()
	local tun=Duel.GetMatchingGroup(c100000152.tmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nont=Duel.GetMatchingGroup(c100000152.ntmatfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local nontmat=nont:FilterSelect(tp,c100000152.synfilter1,1,1,nil,7,tun,c)
	local mat1=nontmat:GetFirst()
	g:AddCard(mat1)
	local lv1=mat1:GetSynchroLevel(c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local t
	if mat1:GetFlagEffect(100000147)==0 then
		t=tun:FilterSelect(tp,c100000152.synfilter2,1,1,nil,7+lv1,c)
	else
		t=tun:FilterSelect(tp,c100000152.synfilter2,1,1,nil,7-lv1,c)
	end
	g:Merge(t)
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c100000152.lmop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c100000152.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c100000152.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c100000152.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp)
end
function c100000152.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c100000152.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000152.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000152.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000152.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c100000152.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
