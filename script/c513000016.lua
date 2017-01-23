--王家の神殿
function c513000016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Trap activate in set turn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE,0)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(29762407,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c513000016.cost)
	e3:SetTarget(c513000016.target)
	e3:SetOperation(c513000016.operation)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,1)
	e4:SetCondition(c513000016.econ)
	e4:SetValue(c513000016.elimit)
	c:RegisterEffect(e4)
	if not c513000016.global_check then
		c513000016.global_check=true
		c513000016[0]=0
		c513000016[1]=0
		--activate limit
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetRange(LOCATION_MZONE)
		ge1:SetOperation(c513000016.aclimit1)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge2:SetCode(EVENT_CHAIN_NEGATED)
		ge2:SetRange(LOCATION_MZONE)
		ge2:SetOperation(c513000016.aclimit2)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetOperation(c513000016.clear)
		Duel.RegisterEffect(ge3,0)
	end
end
function c513000016.cfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c513000016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000016.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
		and Duel.CheckReleaseGroup(tp,nil,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c513000016.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	e:SetLabelObject(g:GetFirst())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c513000016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsPlayerCanSpecialSummon(tp) end
	local tc=e:GetLabelObject()
	if tc then
		Duel.SetTargetCard(tc)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
	end
end
function c513000016.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummon(tp) then return end
	local tc=e:GetLabelObject()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c513000016.aclimit1(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	c513000016[ep]=c513000016[ep]+1
end
function c513000016.aclimit2(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	c513000016[ep]=c513000016[ep]-1
end
function c513000016.clear(e,tp,eg,ep,ev,re,r,rp)
	c513000016[0]=0
	c513000016[1]=0
end
function c513000016.econ(e)
	return c513000016[1-e:GetHandlerPlayer()]>=2
end
function c513000016.elimit(e,te,tp)
	return te:IsHasType(EFFECT_TYPE_ACTIVATE)
end
