--Dark Necrofear (Anime)
--Scripted by Edo9300
function c511004005.initial_effect(c)
	c:EnableReviveLimit()
	--special summon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511004005.spcon)
	e1:SetOperation(c511004005.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c511004005.condition)
	e2:SetTarget(c511004005.target)
	e2:SetOperation(c511004005.operation)
	c:RegisterEffect(e2)
end
function c511004005.spfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsAbleToRemoveAsCost()
end
function c511004005.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511004005.spfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c511004005.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511004005.spfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511004005.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511004005.filter(c)
	return c:IsCode(16625614)
end
function c511004005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c511004005.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil) 
	and Duel.CheckLocation(e:GetHandlerPlayer(),LOCATION_SZONE,5) end
end
function c511004005.cfilter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c511004005.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(e:GetHandlerPlayer(),LOCATION_SZONE,5) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c511004005.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		tc=Duel.SelectTarget(tp,c511004005.cfilter,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
		if not tc or Duel.GetLocationCount(e:GetHandlerPlayer(),LOCATION_SZONE)<=0 then return end
		Duel.Equip(tp,e:GetHandler(),tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511004005.eqlimit)
		e:GetHandler():RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_SET_CONTROL)
		e2:SetValue(tp)
		e2:SetReset(RESET_EVENT+0x1fc0000)
		e:GetHandler():RegisterEffect(e2)
	end
end
function c511004005.eqlimit(e,c)
	return e:GetOwner()==c
end
