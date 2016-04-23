--
function c100015105.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c100015105.fscondition)
	e1:SetOperation(c100015105.fsoperation)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c100015105.atkop)
	c:RegisterEffect(e2)
	--TODECK
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)	
	e3:SetCondition(c100015105.tdcon)
	e3:SetTarget(c100015105.tdtg)
	e3:SetOperation(c100015105.tdop)
	c:RegisterEffect(e3)
end
function c100015105.spfilter(c,mg)
	return c:IsSetCard(0x400) and c:IsSetCard(0x45) 
end
function c100015105.fscondition(e,mg,gc)
	if mg==nil then return false end
	if gc then return false end
	return mg:IsExists(c100015105.spfilter,2,nil,mg)
end
function c100015105.fsoperation(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c100015105.spfilter,2,63,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	Duel.SetFusionMaterial(g1)
end
function c100015105.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	local s=0
	local tc=g:GetFirst()
	while tc do
		local a=tc:GetAttack()
		if a<0 then a=0 end
		s=s+a
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(s/2)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tdc=dg:GetFirst()
	if not tdc or not tdc:IsAbleToRemove() then
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)	
	else
	Duel.DisableShuffleCheck()
	Duel.Remove(tdc,POS_FACEUP,REASON_COST)
	end
end
function c100015105.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c100015105.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,PLAYER_ALL,LOCATION_REMOVED)
end
function c100015105.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_REMOVED,LOCATION_REMOVED)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end