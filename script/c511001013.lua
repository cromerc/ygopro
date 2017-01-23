--E・HERO Clay Guardian
function c511001013.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511001013.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511001013.spcon)
	e2:SetOperation(c511001013.spop)
	c:RegisterEffect(e2)
	--change name
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CHANGE_CODE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(84327329)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511001013,0))
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetTarget(c511001013.damtg)
	e4:SetOperation(c511001013.damop)
	c:RegisterEffect(e4)
	--metamorphosis sp summon success
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetCondition(c511001013.sscon)
	e5:SetOperation(c511001013.ssop)
	c:RegisterEffect(e5)
end
function c511001013.splimit(e,se,sp,st)
	local sc=se:GetHandler()
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or sc:IsCode(46411259)
end
function c511001013.spfilter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c511001013.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511001013.spfilter,tp,LOCATION_MZONE,0,1,nil,84327329)
		and Duel.IsExistingMatchingCard(c511001013.spfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,nil,46411259)
end
function c511001013.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511001013.spfilter,tp,LOCATION_MZONE,0,1,1,nil,84327329)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511001013.spfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil,46411259)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c511001013.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
end
function c511001013.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	Duel.Damage(p,ct*200,REASON_EFFECT)
end
function c511001013.sscon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsCode(46411259)
end
function c511001013.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:CompleteProcedure()
end
