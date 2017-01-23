--Greedy Venom Fusion Dragon (Anime)
function c511009381.initial_effect(c)
	--
	--aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x10f3),c511009381.mat_fil,true)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511009381.funcon)
	e0:SetOperation(c511009381.funop)
	c:RegisterEffect(e0)
	--give effect to material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30086349,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511009381.con)
	e1:SetOperation(c511009381.op)
	c:RegisterEffect(e1)
	--Reduce ATK
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51570882,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009381.atktg)
	e2:SetOperation(c511009381.atkop)
	c:RegisterEffect(e2)
	--destroy and damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51570882,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c511009381.descon)
	e3:SetTarget(c511009381.destg)
	e3:SetOperation(c511009381.desop)
	c:RegisterEffect(e3)
end

---fusion procedure-----
function c511009381.mat_fil(c,fc)
	local attr=c:IsAttribute(ATTRIBUTE_DARK)
	if Card.IsFusionAttribute then
		attr=c:IsFusionAttribute(ATTRIBUTE_DARK,fc)
	end
	return attr and c:GetLevel()>=8
end
function c511009381.funcon(e,g,gc,chkfnf)
	if g==nil then return true end
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionSetCard,0x10f3)
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return (c511009381.mat_fil(gc,c) and mg:IsExists(f2,1,gc,c))
			or (f2(gc) and mg:IsExists(c511009381.mat_fil,1,gc,c)) end
	local g1=Group.CreateGroup() local g2=Group.CreateGroup() local fs=false
	local tc=mg:GetFirst()
	while tc do
		if c511009381.mat_fil(tc,c) then g1:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		if f2(tc) then g2:AddCard(tc) if Auxiliary.FConditionCheckF(tc,chkf) then fs=true end end
		tc=mg:GetNext()
	end
	if chkf~=PLAYER_NONE then
		return fs and g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2)
	else return g1:IsExists(Auxiliary.FConditionFilterF2,1,nil,g2) end
end
function c511009381.funop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local c=e:GetHandler()
	local f2=aux.FilterBoolFunction(Card.IsFusionSetCard,0x10f3)
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		local sg=Group.CreateGroup()
		if c511009381.mat_fil(gc,c) then sg:Merge(g:Filter(f2,gc,c)) end
		if f2(gc) then sg:Merge(g:Filter(c511009381.mat_fil,gc,c)) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,1,1,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	local sg=g:Filter(c511009381.FConditionFilterF2c,nil,c)
	local g1=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	if chkf~=PLAYER_NONE then
		g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
	else g1=sg:Select(tp,1,1,nil) end
	local tc1=g1:GetFirst()
	sg:RemoveCard(tc1)
	local b1=c511009381.mat_fil(tc1,c)
	local b2=f2(tc1)
	if b1 and not b2 then sg:Remove(c511009381.FConditionFilterF2r1,nil,c) end
	if b2 and not b1 then sg:Remove(c511009381.FConditionFilterF2r2,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=sg:Select(tp,1,1,nil)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c511009381.FConditionFilterF2c(c,fc)
	return c511009381.mat_fil(c,fc) or c:IsFusionSetCard(0x10f3)
end
function c511009381.FConditionFilterF2r1(c,fc)
	return c511009381.mat_fil(c,fc) and not c:IsFusionSetCard(0x10f3)
end
function c511009381.FConditionFilterF2r2(c,fc)
	return c:IsFusionSetCard(0x10f3) and not c511009381.mat_fil(c,fc)
end
-------------------
function c511009381.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c511009381.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	while tc do
		--special summon
		local e4=Effect.CreateEffect(c)
		e4:SetDescription(aux.Stringid(18175965,0))
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e4:SetCode(EVENT_TO_GRAVE)
		e4:SetRange(tc:GetLocation())
		e4:SetCondition(c511009381.spcon)
		e4:SetCost(c511009381.spcost)
		e4:SetTarget(c511009381.sptg)
		e4:SetReset(RESET_EVENT+0x1ff0000)
		e4:SetOperation(c511009381.spop)
		tc:RegisterEffect(e4)
		
		tc=g:GetNext()
	end

end
function c511009381.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:GetPreviousControler()==tp
		and c:IsReason(REASON_DESTROY) and c:IsCode(51570882)
end
function c511009381.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009381.cfilter,1,nil,tp)
end
function c511009381.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and e:GetHandler():IsLocation(LOCATION_GRAVE) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511009381.spfilter(c,e,tp)
	return c:IsCode(51570882) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009381.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009381.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511009381.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009381.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		--forbidden
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(EFFECT_FORBIDDEN)
		e1:SetTargetRange(0x7f,0x7f)
		e1:SetTarget(c511009381.bantg)
		e1:SetLabel(ac)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		end
end
function c511009381.bantg(e,c)
	return c:IsCode(7610)
end
--------------------
function c511009381.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c511009381.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if ((tc:IsFaceup() and not tc:IsDisabled()) or tc:IsType(TYPE_TRAPMONSTER)) and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e0=Effect.CreateEffect(c)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e0:SetCode(EFFECT_SET_ATTACK_FINAL)
		e0:SetValue(0)
		e0:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
		end
	end
end

function c511009381.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511009381.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511009381.ctfilter(c,tp)
	return c:GetPreviousControler()==tp
end
function c511009381.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local g1=dg:Filter(c511009381.ctfilter,nil,tp)
		local g2=dg:Filter(c511009381.ctfilter,nil,1-tp)
		local sum1=g1:GetSum(Card.GetAttack)
		local sum2=g2:GetSum(Card.GetAttack)
		Duel.Damage(tp,sum1,REASON_EFFECT)
		Duel.Damage(1-tp,sum2,REASON_EFFECT)
	end
end
