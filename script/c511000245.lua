--邪神アバター
--マイケル・ローレンス・ディーによってスクリプト
function c511000245.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000245.ttcon)
	e1:SetOperation(c511000245.ttop)
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
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c511000245.adval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_DEFENSE_FINAL)
	c:RegisterEffect(e5)
	--aclimit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_SUMMON_SUCCESS)
	e6:SetOperation(c511000245.regop)
	c:RegisterEffect(e6)
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
	e8:SetOperation(c511000245.sumsuc)
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
	e11:SetValue(c511000245.efilter)
	c:RegisterEffect(e11)
	--cannot be target
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetValue(c511000245.tgfilter)
	c:RegisterEffect(e10)
	--ATK/DEF effects are only applied until the End Phase
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_REPEAT)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetCountLimit(1)
	e13:SetOperation(c511000245.atkdefresetop)
	c:RegisterEffect(e13)
	--negate
	local e16=Effect.CreateEffect(c)
	e16:SetDescription(aux.Stringid(51100236,6))
	e16:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e16:SetCode(EVENT_BE_BATTLE_TARGET)
	e16:SetCondition(c511000245.negcon)
	e16:SetOperation(c511000245.negop)
	c:RegisterEffect(e16)
	--indestructable
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e17:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e17:SetRange(LOCATION_MZONE)
	e17:SetValue(1)
	c:RegisterEffect(e17)
end
function c511000245.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000245.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000245.filter(c)
	return c:IsFaceup() and c:GetCode()~=21208154
end
function c511000245.adval(e,c)
	local g=Duel.GetMatchingGroup(c511000245.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 1
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		return val+1
	end
end
function c511000245.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c511000245.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	Duel.RegisterEffect(e1,tp)
end 
function c511000245.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511000245.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c511000245.chainlm)
end
function c511000245.chainlm(e,rp,tp)
	return e:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000245.efilter(e,te)
	return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end
function c511000245.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c511000245.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card)
end
function c511000245.negcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsFaceup() and a:IsAttribute(ATTRIBUTE_DEVINE) and a:IsRace(RACE_DEVINE) 
		and not a:IsCode(10000011) and not a:IsCode(21208154)
end
function c511000245.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511000245.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c511000245.adval)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c511000245.adval)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local eqg=c:GetEquipGroup()
	local tgg=Duel.GetMatchingGroup(c511000245.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	if eqg:GetCount()>0 then
		Duel.Destroy(eqg,REASON_EFFECT)
	end
end
--MLD
