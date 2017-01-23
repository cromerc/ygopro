--Spirit Contamination
function c511001442.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511001442.condition)
	e1:SetTarget(c511001442.target)
	e1:SetOperation(c511001442.activate)
	c:RegisterEffect(e1)
	if not c511001442.global_check then
		c511001442.global_check=true
		c511001442[0]=false
		c511001442[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511001442.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001442.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001442.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsControler(tp)
end
function c511001442.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511001442.cfilter,1,nil,tp) then
		c511001442[tp]=true
	end
	if eg:IsExists(c511001442.cfilter,1,nil,1-tp) then
		c511001442[1-tp]=true
	end
end
function c511001442.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001442[0]=false
	c511001442[1]=false
end
function c511001442.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511001442[tp]
end
function c511001442.filter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511001442.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511001442.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001442.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001442.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001442.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
