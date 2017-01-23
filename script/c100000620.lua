--新生代化石マシン　スカルバギー
function c100000620.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c100000620.fcon)
	e1:SetOperation(c100000620.fop)
	c:RegisterEffect(e1)
	--cannot spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetValue(c100000620.splimit)
	c:RegisterEffect(e2)
end
function c100000620.splimit(e,se,sp,st)
	if bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION then return se:GetHandler():IsCode(100000025)
	else return true end
end
function c100000620.filter1(c,tp)
	return (c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)) or c:IsHasEffect(511002961)
end
function c100000620.filter2(c,tp)
	return (c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp)) or c:IsHasEffect(511002961)
end
function c100000620.fcon(e,g,gc,chkfnf)
	local tp=e:GetHandlerPlayer()
	local chkf=bit.band(chkfnf,0xff)
	if g==nil then return true end
	if gc then return (c100000620.filter1(gc,tp) and g:IsExists(c100000620.filter2,1,gc,tp))
		or (c100000620.filter2(gc,tp) and g:IsExists(c100000620.filter1,1,gc,tp)) end
	local b1=0 local b2=0 local b3=0 local ct=0
	local tc=g:GetFirst()
	while tc do
		local match=false
		if tc:IsHasEffect(511002961) then b3=b3+1 match=true
		else
			if c100000620.filter1(tc,tp) then b1=1 match=true end
			if c100000620.filter2(tc,tp) then b2=1 match=true end
		end
		if match==true then ct=ct+1 end
		tc=g:GetNext()
	end
	return b1+b2+b3>1 and ct>1 and chkf==PLAYER_NONE
end
function c100000620.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local tp=e:GetHandlerPlayer()
	if gc then
		local sg=Group.CreateGroup()
		if c100000620.filter1(gc,tp) then sg:Merge(eg:Filter(c100000620.filter2,gc,tp)) end
		if c100000620.filter2(gc,tp) then sg:Merge(eg:Filter(c100000620.filter1,gc,tp)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local g1=eg:Filter(c100000620.filter1,nil,tp)
	local g2=eg:Filter(c100000620.filter2,nil,tp)
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
