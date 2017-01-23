--邪神ドレッド・ルート
--マイケル・ローレンス・ディーによってスクリプト
function c511000259.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000259.ttcon)
	e1:SetOperation(c511000259.ttop)
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
	--half atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c511000259.atktg)
	e4:SetValue(c511000259.atkval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e5:SetValue(c511000259.defval)
	c:RegisterEffect(e5)
	--Summon Cannot be Negated
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e7)
	--summon success
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetOperation(c511000259.sumsuc)
	c:RegisterEffect(e8)
	--control
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e9)
	--immune effect
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(c511000259.efilter)
	c:RegisterEffect(e11)
	--cannot be target
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c511000259.tgfilter)
	c:RegisterEffect(e10)
	--ATK/DEF effects are only applied until the End Phase
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_REPEAT)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetCountLimit(1)
	e13:SetOperation(c511000259.atkdefresetop)
	c:RegisterEffect(e13)
	--indestructable
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e17:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e17:SetRange(LOCATION_MZONE)
	e17:SetValue(c511000259.indes)
	c:RegisterEffect(e17)
end
function c511000259.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000259.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000259.atktg(e,c)
	return c~=e:GetHandler()
end
function c511000259.atkval(e,c)
	return c:GetAttack()/2
end
function c511000259.defval(e,c)
	return c:GetDefense()/2
end
function c511000259.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c511000259.chainlm)
end
function c511000259.chainlm(e,rp,tp)
	return e:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000259.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner() and not te:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000259.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c511000259.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card)
end
function c511000259.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c:GetBaseDefense())
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local eqg=c:GetEquipGroup()
	local tgg=Duel.GetMatchingGroup(c511000259.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	if eqg:GetCount()>0 then
		Duel.Destroy(eqg,REASON_EFFECT)
	end
end
function c511000259.indes(e,re,rp)
	return not re:GetOwner():IsCode(10000010)
end
--MLD
