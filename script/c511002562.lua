--Reserve Cyclone
function c511002562.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DELAYED_QUICKEFFECT)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_RELEASE)
	e1:SetCondition(c511002562.condition)
	e1:SetTarget(c511002562.target)
	e1:SetOperation(c511002562.activate)
	c:RegisterEffect(e1)
	if not c511002562.global_check then
		c511002562.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CONTROL_CHANGED)
		ge1:SetOperation(c511002562.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002562.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511002562,RESET_EVENT+0x3100000,0,0)
		tc=eg:GetNext()
	end
end
function c511002562.cfilter(c)
	return c:GetFlagEffect(511002562)>0
end
function c511002562.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002562.cfilter,1,nil)
end
function c511002562.filter(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511002562.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511002562.filter(chkc) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002562.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511002562.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002562.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
