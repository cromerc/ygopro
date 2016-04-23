--
function c100015106.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c100015106.fscondition)
	e1:SetOperation(c100015106.fsoperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c100015106.atkop)
	c:RegisterEffect(e2)
	--REMOVED
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVED)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)	
	e3:SetCondition(c100015106.tdcon)
	e3:SetTarget(c100015106.tdtg)
	e3:SetOperation(c100015106.tdop)
	c:RegisterEffect(e3)
	--defup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_DEFENCE)
	e4:SetValue(c100015106.operation)
	c:RegisterEffect(e4)
	--atkup
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c100015106.operation2)
	c:RegisterEffect(e5)
end
function c100015106.spfilter(c,mg)
	return c:IsSetCard(0x400) and c:IsSetCard(0x45) and mg:IsExists(Card.IsType,1,c,TYPE_MONSTER)
end
function c100015106.fscondition(e,mg,gc)
	if mg==nil then return false end
	if gc then return false end
	return mg:IsExists(c100015106.spfilter,1,nil,mg)
end
function c100015106.fsoperation(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c100015106.spfilter,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=eg:FilterSelect(tp,Card.IsType,1,63,g1:GetFirst(),TYPE_MONSTER)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c100015106.atkop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetDecktopGroup(tp,1)
	local tdc=dg:GetFirst()
	if not tdc or not tdc:IsAbleToRemove() then
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)	
	else
	Duel.DisableShuffleCheck()
	Duel.Remove(tdc,POS_FACEUP,REASON_COST)
	end
end
function c100015106.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c100015106.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVED,nil,1,PLAYER_ALL,LOCATION_GRAVE)
end
function c100015106.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,LOCATION_GRAVE)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c100015106.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x400) and c:IsSetCard(0x45) 
end
function c100015106.operation(e,c)
	local wup=0
	local wg=Duel.GetMatchingGroup(c100015106.filter,c:GetControler(),LOCATION_MZONE,0,c)
	local wbc=wg:GetFirst()
	while wbc do
		wup=wup+wbc:GetDefence()
		wbc=wg:GetNext()
	end
	return wup/2
end
function c100015106.operation2(e,c)
	local wdp=0
	local wd=Duel.GetMatchingGroup(c100015106.filter,c:GetControler(),LOCATION_MZONE,0,c)
	local wdc=wd:GetFirst()
	while wdc do
		wdp=wdp+wdc:GetAttack()
		wdc=wd:GetNext()
	end
	return wdp/2
end