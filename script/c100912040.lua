--ＥＭガトリングール
--Performapal Gatling Ghoul
--Scripted by Eerie Code
function c100912040.initial_effect(c)
	--fusion procedure
	c:EnableReviveLimit()
	--aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f),c100912040.mat_filter,true)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c100912040.funcon)
	e0:SetOperation(c100912040.funop)
	c:RegisterEffect(e0)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100912040,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,100912040)
	e1:SetCondition(c100912040.damcon)
	e1:SetTarget(c100912040.damtg)
	e1:SetOperation(c100912040.damop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c100912040.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c100912040.mat_filter(c)
	return c:IsFusionAttribute(ATTRIBUTE_DARK) and c:IsLevelAbove(5)
end
function c100912040.mat_fil_temp(c,fc)
	local attr=c:IsAttribute(ATTRIBUTE_DARK)
	if Card.IsFusionAttribute then
		attr=c:IsFusionAttribute(ATTRIBUTE_DARK,fc)
	end
	return attr and c:IsLevelAbove(5)
end
function c100912040.funcon(e,g,gc,chkfnf)
	if g==nil then return true end
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f)
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return (c100912040.mat_fil_temp(gc,c) and mg:IsExists(f2,1,gc,c))
			or (f2(gc) and mg:IsExists(c100912040.mat_fil_temp,1,gc,c)) end
	local g1=Group.CreateGroup() local g2=Group.CreateGroup() local fs=false
	local tc=mg:GetFirst()
	while tc do
		if c100912040.mat_fil_temp(tc,c) then g1:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		if f2(tc) then g2:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		tc=mg:GetNext()
	end
	if chkf~=PLAYER_NONE then
		return fs and g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2)
	else return g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2) end
end
function c100912040.funop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f)
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		local sg=Group.CreateGroup()
		if c100912040.mat_fil_temp(gc,c) then sg:Merge(g:Filter(f2,gc,c)) end
		if f2(gc) then sg:Merge(g:Filter(c100912040.mat_fil_temp,gc,c)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local sg=g:Filter(c100912040.FConditionFilterF2c,nil,c)
	local g1=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	if chkf~=PLAYER_NONE then
		g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
	else g1=sg:Select(tp,1,1,nil) end
	local tc1=g1:GetFirst()
	sg:RemoveCard(tc1)
	local b1=c100912040.mat_fil_temp(tc1,c)
	local b2=f2(tc1)
	if b1 and not b2 then sg:Remove(c100912040.FConditionFilterF2r1,nil,c) end
	if b2 and not b1 then sg:Remove(c100912040.FConditionFilterF2r2,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=sg:Select(tp,1,1,nil)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c100912040.FConditionFilterF2c(c,fc)
	return c100912040.mat_fil_temp(c,fc) or c:IsFusionSetCard(0x9f)
end
function c100912040.FConditionFilterF2r1(c,fc)
	return c100912040.mat_fil_temp(c,fc) and not c:IsFusionSetCard(0x9f)
end
function c100912040.FConditionFilterF2r2(c,fc)
	return c:IsFusionSetCard(0x9f) and not c100912040.mat_fil_temp(c,fc)
end
function c100912040.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c100912040.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dc=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dc*200)
	if e:GetLabel()==1 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c100912040.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if ct>0 and Duel.Damage(p,ct*200,REASON_EFFECT)~=0 and e:GetLabel()==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.BreakEffect()
			Duel.HintSelection(g)
			if Duel.Destroy(g,REASON_EFFECT)~=0 then
				local dam=g:GetFirst():GetBaseAttack()
				Duel.Damage(p,dam,REASON_EFFECT)
			end
		end
	end
end
function c100912040.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	if g:IsExists(Card.IsType,1,nil,TYPE_PENDULUM) then
		flag=1
	end
	e:GetLabelObject():SetLabel(flag)
end