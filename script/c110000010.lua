--ラーの翼神竜WCS効果
function c110000010.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c110000010.ttcon)
	e1:SetOperation(c110000010.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c110000010.setcon)
	c:RegisterEffect(e2)
	--summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c110000010.sumsuc)
	c:RegisterEffect(e4)
	--cannot be target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--to grave
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(110000010,0))
	e6:SetCategory(CATEGORY_TOGRAVE)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_REPEAT)
	e6:SetCountLimit(1)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetCondition(c110000010.tgcon)
	e6:SetTarget(c110000010.tgtg)
	e6:SetOperation(c110000010.tgop)
	c:RegisterEffect(e6)

	--atk
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_MATERIAL_CHECK)
	e7:SetValue(c110000010.valcheck)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_SUMMON_SUCCESS)
	e8:SetOperation(c110000010.atkop)
	c:RegisterEffect(e8)

	--effect
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(110000010,0))
	e9:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e9:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e9:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	e9:SetOperation(c110000010.op)
	c:RegisterEffect(e9)

end

function c110000010.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c110000010.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c110000010.setcon(e,c)
	if not c then return true end
	return false
end
function c110000010.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c110000010.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c110000010.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c110000010.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end

function c110000010.valcheck(e,c)
	local g=c:GetMaterial()
	c110000010.atk=g:GetSum(Card.GetBaseAttack)
	c110000010.def=g:GetSum(Card.GetBaseDefence)
end
function c110000010.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterialCount()==0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c110000010.atk)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENCE)
	e2:SetValue(c110000010.def)
	c:RegisterEffect(e2)
end

function c110000010.op(e,tp,eg,ep,ev,re,r,rp,chk,chkc)

	local op=0
	local b1=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,0)
	local b2=Duel.IsExistingMatchingCard(c110000010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())

	if Duel.CheckLPCost(tp,1000) then
		if b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(10000010,0),aux.Stringid(10000010,1))
	end

	
	elseif b1 then op=Duel.SelectOption(tp,aux.Stringid(10000010,0))
	elseif b2 then Duel.SelectOption(tp,aux.Stringid(10000010,1)) op=1
	else return end
	if op==0 then
		if chk==0 then return Duel.GetLP(tp)>1 end
		local lp=Duel.GetLP(tp)
		e:SetLabel(lp-1)
		Duel.PayLPCost(tp,lp-1)
		local c=e:GetHandler()
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(e:GetLabel())
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENCE)
			c:RegisterEffect(e2)
		end
	else
		
		Duel.PayLPCost(tp,1000)
		local g=Duel.SelectTarget(tp,c110000010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT,LOCATION_REMOVED)
	end
end

function c110000010.filter(c,e)
	return not e or c:IsRelateToEffect(e)
end