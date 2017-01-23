--Bee Force - Big Ballista the Final Battle
function c511001948.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511001948.syncon)
	e1:SetOperation(c511001948.synop)
	e1:SetValue(SUMMON_TYPE_SYNCHRO)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001948,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511001948.atkcon)
	e2:SetCost(c511001948.atkcost)
	e2:SetTarget(c511001948.atktg)
	e2:SetOperation(c511001948.atkop)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c511001948.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001948.matfilter(c,syncard)
	return c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard)
end
function c511001948.synfilter1(c,syncard,lv,g)
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	if c:IsNotTuner() then return false end
	local wg=g:Clone()
	wg:RemoveCard(c)
	return wg:IsExists(c511001948.synfilter2,1,nil,syncard,lv-tlv,wg)
end
function c511001948.synfilter2(c,syncard,lv,g)
	if not c:IsSetCard(0x214) or not c:IsType(TYPE_SYNCHRO) then return false end
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	return g:IsExists(c511001948.synfilter3,1,c,syncard,lv-tlv)
end
function c511001948.synfilter3(c,syncard,lv)
	local mlv=c:GetSynchroLevel(syncard)
	local lv1=bit.band(mlv,0xffff)
	local lv2=bit.rshift(mlv,16)
	return c:IsNotTuner() and (lv1==lv or lv2==lv)
end
function c511001948.syncon(e,c,tuner)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c511001948.matfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local lv=c:GetLevel()
	if tuner then return c511001948.synfilter1(tuner,c,lv,mg) end
	return mg:IsExists(c511001948.synfilter1,1,nil,c,lv,mg)
end
function c511001948.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local g=Group.CreateGroup()
	local mg=Duel.GetMatchingGroup(c511001948.matfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local lv=c:GetLevel()
	local m1=tuner
	if not tuner then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local t1=mg:FilterSelect(tp,c511001948.synfilter1,1,1,nil,c,lv,mg)
		m1=t1:GetFirst()
		g:AddCard(m1)
	end
	lv=lv-m1:GetSynchroLevel(c)
	mg:RemoveCard(m1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local t2=mg:FilterSelect(tp,c511001948.synfilter2,1,1,nil,c,lv,mg)
	local m2=t2:GetFirst()
	g:AddCard(m2)
	lv=lv-m2:GetSynchroLevel(c)
	mg:RemoveCard(m2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local t3=mg:FilterSelect(tp,c511001948.synfilter3,1,1,nil,c,lv)
	g:Merge(t3)
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c511001948.cfilter(c)
	return c:IsSetCard(0x214) and c:IsType(TYPE_MONSTER)
end
function c511001948.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511001948.cfilter,tp,LOCATION_GRAVE,0,e:GetHandler())
	if chk==0 then return g:GetCount()>0 and g:FilterCount(Card.IsAbleToRemoveAsCost,nil)==g:GetCount() end
	e:SetLabel(g:GetCount())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001948.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511001948.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*-500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
