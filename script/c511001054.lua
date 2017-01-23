--Phantom Wing
function c511001054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511001054.condition)
	e1:SetTarget(c511001054.target)
	e1:SetOperation(c511001054.activate)
	c:RegisterEffect(e1)
	--
	local e2=e1:Clone()
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511001054.con2)
	c:RegisterEffect(e2)
end
function c511001054.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c511001054.cfilter(c)
	return c:IsOnField() and c:IsType(TYPE_MONSTER)
end
function c511001054.con2(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return Duel.GetCurrentPhase()~=PHASE_BATTLE and ex and tg~=nil and tc+tg:FilterCount(c511001054.cfilter,nil)-tg:GetCount()>0
end
function c511001054.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,nil) end
end
function c511001054.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetTarget(c511001054.reptg)
		e1:SetOperation(c511001054.repop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511001054.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return true
end
function c511001054.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(500)
	c:RegisterEffect(e1)
end
