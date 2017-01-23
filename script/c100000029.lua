--古生代化石竜 スカルギオス
function c100000029.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c100000029.fcon)
	e0:SetOperation(c100000029.fop)
	c:RegisterEffect(e0)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100000029.splimit)
	c:RegisterEffect(e1)
	--atk/def swap
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000029,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetTarget(c100000029.attg)
	e2:SetOperation(c100000029.atop)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c100000029.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION and se:GetHandler():IsCode(100000025)
end
function c100000029.filter1(c,tp)
	return (c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)) or c:IsHasEffect(511002961)
end
function c100000029.filter2(c,tp)
	return (c:IsLevelAbove(8) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)) or c:IsHasEffect(511002961)
end
function c100000029.fcon(e,g,gc,chkfnf)
	local tp=e:GetHandlerPlayer()
	local chkf=bit.band(chkfnf,0xff)
	if g==nil then return true end
	if gc then return (c100000029.filter1(gc,tp) and g:IsExists(c100000029.filter2,1,gc,tp))
		or (c100000029.filter2(gc,tp) and g:IsExists(c100000029.filter1,1,gc,tp)) end
	local b1=0 local b2=0 local b3=0 local ct=0
	local tc=g:GetFirst()
	while tc do
		local match=false
		if tc:IsHasEffect(511002961) then b3=b3+1 match=true
		else
			if c100000029.filter1(tc,tp) then b1=1 match=true end
			if c100000029.filter2(tc,tp) then b2=1 match=true end
		end
		if match==true then ct=ct+1 end
		tc=g:GetNext()
	end
	return b1+b2+b3>1 and ct>1 and chkf==PLAYER_NONE
end
function c100000029.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if gc then
		local sg=Group.CreateGroup()
		if c100000029.filter1(gc,tp) then sg:Merge(eg:Filter(c100000029.filter2,gc,tp)) end
		if c100000029.filter2(gc,tp) then sg:Merge(eg:Filter(c100000029.filter1,gc,tp)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local g1=eg:Filter(c100000029.filter1,nil,tp)
	local g2=eg:Filter(c100000029.filter2,nil,tp)
	if g1:GetCount()==1 and g2:GetCount()>1 then
		g2:Sub(g1)
	elseif g2:GetCount()==1 and g1:GetCount()>1 then
		g1:Sub(g2)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local tc1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local tc2=g2:Select(tp,1,1,tc1:GetFirst())
	tc1:Merge(tc2)
	Duel.SetFusionMaterial(tc1)
end
function c100000029.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttackTarget()
	if chkc then return tg and chkc==tg end
	if chk==0 then return tg and tg:IsFaceup() and tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c100000029.atop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
	end
end
