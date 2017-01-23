--邪神イレイザー
--マイケル・ローレンス・ディーによってスクリプト
function c511000257.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000257.ttcon)
	e1:SetOperation(c511000257.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e2)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c511000257.adval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e5)
	--Eraser
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(57793869,0))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c511000257.erascon)
	e6:SetTarget(c511000257.erastg)
	e6:SetOperation(c511000257.erasop)
	c:RegisterEffect(e6)
	--suicide
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(57793869,1))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTarget(c511000257.destg)
	e7:SetOperation(c511000257.desop)
	c:RegisterEffect(e7)
	--Summon Cannot be Negated
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e8)
	--cannot be target
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c511000257.tgfilter)
	c:RegisterEffect(e10)
	--ATK/DEF effects are only applied until the End Phase
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_REPEAT)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetCountLimit(1)
	e13:SetOperation(c511000257.atkdefresetop)
	c:RegisterEffect(e13)
	--indestructable
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e17:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e17:SetRange(LOCATION_MZONE)
	e17:SetValue(c511000257.indes)
	c:RegisterEffect(e17)
end
function c511000257.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000257.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000257.adval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_ONFIELD)*1000
end
function c511000257.erascon(e)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511000257.erastg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c511000257.erasop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(dg,REASON_EFFECT)
end
function c511000257.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511000257.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511000257.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c511000257.chainlm)
end
function c511000257.chainlm(e,rp,tp)
	return e:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000257.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner() and not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000257.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c511000257.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card)
end
function c511000257.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c511000257.adval)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c511000257.adval)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local eqg=c:GetEquipGroup()
	local tgg=Duel.GetMatchingGroup(c511000257.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	if eqg:GetCount()>0 then
		Duel.Destroy(eqg,REASON_EFFECT)
	end
end
function c511000257.indes(e,re,rp)
	return not re:GetOwner():IsCode(10000010) and re:GetOwner()~=e:GetOwner()
end
--MLD
