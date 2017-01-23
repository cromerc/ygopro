--Performapal Gatling Ghoul
--Fixed by TheOnePharaoh
function c511009368.initial_effect(c)
	--fusion material
	--aux.AddFusionProcFun2(c,c511009368.mat_fil,aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f),true)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511009368.funcon)
	e0:SetOperation(c511009368.funop)
	c:RegisterEffect(e0)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29343734,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511009368.damcon)
	e1:SetTarget(c511009368.damtg)
	e1:SetOperation(c511009368.damop)
	c:RegisterEffect(e1)
	--Material Check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511009368.matregcon)
	e2:SetOperation(c511009368.matregop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66970002,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511009368.condition)
	e3:SetTarget(c511009368.target)
	e3:SetOperation(c511009368.operation)
	c:RegisterEffect(e3)
end
function c511009368.mat_fil(c,fc)
	local attr=c:IsAttribute(ATTRIBUTE_DARK)
	if Card.IsFusionAttribute then
		attr=c:IsFusionAttribute(ATTRIBUTE_DARK,fc)
	end
	return attr and c:GetLevel()>=5
end
function c511009368.funcon(e,g,gc,chkfnf)
	if g==nil then return true end
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f)
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return (c511009368.mat_fil(gc,c) and mg:IsExists(f2,1,gc,c))
			or (f2(gc) and mg:IsExists(c511009368.mat_fil,1,gc,c)) end
	local g1=Group.CreateGroup() local g2=Group.CreateGroup() local fs=false
	local tc=mg:GetFirst()
	while tc do
		if c511009368.mat_fil(tc,c) then g1:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		if f2(tc) then g2:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		tc=mg:GetNext()
	end
	if chkf~=PLAYER_NONE then
		return fs and g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2)
	else return g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2) end
end
function c511009368.funop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionSetCard,0x9f)
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		local sg=Group.CreateGroup()
		if c511009368.mat_fil(gc,c) then sg:Merge(g:Filter(f2,gc)) end
		if f2(gc) then sg:Merge(g:Filter(c511009368.mat_fil,gc,c)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local sg=g:Filter(c511009368.FConditionFilterF2c,nil,c)
	local g1=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	if chkf~=PLAYER_NONE then
		g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
	else g1=sg:Select(tp,1,1,nil) end
	local tc1=g1:GetFirst()
	sg:RemoveCard(tc1)
	local b1=c511009368.mat_fil(tc1,c)
	local b2=f2(tc1)
	if b1 and not b2 then sg:Remove(c511009368.FConditionFilterF2r1,nil,c) end
	if b2 and not b1 then sg:Remove(c511009368.FConditionFilterF2r2,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=sg:Select(tp,1,1,nil)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c511009368.FConditionFilterF2c(c,fc)
	return c511009368.mat_fil(c,fc) or c:IsFusionSetCard(0x9f)
end
function c511009368.FConditionFilterF2r1(c,fc)
	return c511009368.mat_fil(c,fc) and not c:IsFusionSetCard(0x9f)
end
function c511009368.FConditionFilterF2r2(c,fc)
	return c:IsFusionSetCard(0x9f) and not c511009368.mat_fil(c,fc)
end

function c511009368.damcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c511009368.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,0xc,0xc)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
end
function c511009368.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,0xc,0xc)
	Duel.Damage(p,ct*200,REASON_EFFECT)
end
function c511009368.matfilter(c)
	return c:IsType(TYPE_PENDULUM) 
end
function c511009368.matregcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION and e:GetHandler():GetMaterial():IsExists(c511009368.matfilter,1,nil)
end
function c511009368.matregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(511009368,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511009368.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511009368)~=0
end
function c511009368.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetAttack())
end
function c511009368.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		if atk<0 or tc:IsFacedown() then atk=0 end
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
