--古生代化石騎士 スカルキング
function c100000028.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c100000028.fcon)
	e0:SetOperation(c100000028.fop)
	c:RegisterEffect(e0)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c100000028.splimit)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c100000028.atcon)
	e2:SetOperation(c100000028.atop)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c100000028.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION and se:GetHandler():IsCode(100000025)
end
function c100000028.filter1(c,tp)
	return (c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)) or c:IsHasEffect(511002961)
end
function c100000028.filter2(c,tp)
	return (c:IsLevelAbove(7) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)) or c:IsHasEffect(511002961)
end
function c100000028.fcon(e,g,gc,chkfnf)
	local tp=e:GetHandlerPlayer()
	local chkf=bit.band(chkfnf,0xff)
	if g==nil then return true end
	if gc then return (c100000028.filter1(gc,tp) and g:IsExists(c100000028.filter2,1,gc,tp))
		or (c100000028.filter2(gc,tp) and g:IsExists(c100000028.filter1,1,gc,tp)) end
	local b1=0 local b2=0 local b3=0 local ct=0
	local tc=g:GetFirst()
	while tc do
		local match=false
		if tc:IsHasEffect(511002961) then b3=b3+1 match=true
		else
			if c100000028.filter1(tc,tp) then b1=1 match=true end
			if c100000028.filter2(tc,tp) then b2=1 match=true end
		end
		if match==true then ct=ct+1 end
		tc=g:GetNext()
	end
	return b1+b2+b3>1 and ct>1 and chkf==PLAYER_NONE
end
function c100000028.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if gc then
		local sg=Group.CreateGroup()
		if c100000028.filter1(gc,tp) then sg:Merge(eg:Filter(c100000028.filter2,gc,tp)) end
		if c100000028.filter2(gc,tp) then sg:Merge(eg:Filter(c100000028.filter1,gc,tp)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local g1=eg:Filter(c100000028.filter1,nil,tp)
	local g2=eg:Filter(c100000028.filter2,nil,tp)
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
function c100000028.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsChainAttackable()
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
end
function c100000028.atop(e,tp,eg,ep,ev,re,r,rp)	
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)	
		e1:SetCondition(c100000028.con)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c100000028.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(e:GetOwnerPlayer(),0,LOCATION_MZONE)>0
end
