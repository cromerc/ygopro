--C/C/C Sonic Halberd of Battle
function c511009382.initial_effect(c)
c:EnableReviveLimit()
	--aux.AddFusionProcFun2(c,c511009382.mat_fil,aux.FilterBoolFunction(Card.IsFusionSetCard,511009400),true)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511009382.funcon)
	e0:SetOperation(c511009382.funop)
	c:RegisterEffect(e0)

	--multiattack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c511009382.val)
	c:RegisterEffect(e1)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46132282,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c511009382.effop)
	c:RegisterEffect(e1)
end

function c511009382.mat_fil(c,fc)
	local attr=c:IsAttribute(ATTRIBUTE_WIND)
	if Card.IsFusionAttribute then
		attr=c:IsFusionAttribute(ATTRIBUTE_WIND,fc)
	end
	return attr and c:GetLevel()>=7
end


function c511009382.funcon(e,g,gc,chkfnf)
	if g==nil then return true end
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionCode,511009400)
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return (c511009382.mat_fil(gc,c) and mg:IsExists(f2,1,gc,c))
			or (f2(gc) and mg:IsExists(c511009382.mat_fil,1,gc,c)) end
	local g1=Group.CreateGroup() local g2=Group.CreateGroup() local fs=false
	local tc=mg:GetFirst()
	while tc do
		if c511009382.mat_fil(tc,c) then g1:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		if f2(tc) then g2:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		tc=mg:GetNext()
	end
	if chkf~=PLAYER_NONE then
		return fs and g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2)
	else return g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2) end
end
function c511009382.funop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionCode,511009400)
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		local sg=Group.CreateGroup()
		if c511009382.mat_fil(gc,c) then sg:Merge(g:Filter(f2,gc)) end
		if f2(gc) then sg:Merge(g:Filter(c511009382.mat_fil,gc,c)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local sg=g:Filter(c511009382.FConditionFilterF2c,nil,c)
	local g1=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	if chkf~=PLAYER_NONE then
		g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
	else g1=sg:Select(tp,1,1,nil) end
	local tc1=g1:GetFirst()
	sg:RemoveCard(tc1)
	local b1=c511009382.mat_fil(tc1,c)
	local b2=f2(tc1)
	if b1 and not b2 then sg:Remove(c511009382.FConditionFilterF2r1,nil,c) end
	if b2 and not b1 then sg:Remove(c511009382.FConditionFilterF2r2,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=sg:Select(tp,1,1,nil)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c511009382.FConditionFilterF2c(c,fc)
	return c511009382.mat_fil(c,fc) or c:IsFusionCode(511009400)
end
function c511009382.FConditionFilterF2r1(c,fc)
	return c511009382.mat_fil(c,fc) and not c:IsFusionCode(511009400)
end
function c511009382.FConditionFilterF2r2(c,fc)
	return c:IsFusionCode(511009400) and not c511009382.mat_fil(c,fc)
end

function c511009382.attfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c511009382.val(e,c)
	if Duel.IsExistingMatchingCard(c511009382.attfilter,tp,0,LOCATION_MZONE,1,nil) then
	return 3
	else 
	return 2
	end
end
function c511009382.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		c:RegisterEffect(e2)
	end
end
