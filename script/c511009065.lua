--Superheavy Samurai Ninja Sarutobi
function c511009065.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--add setcode
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetValue(0x9a)
	c:RegisterEffect(e1)
	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96029574,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009065.destg)
	e2:SetCondition(c511009065.descon)
	e2:SetOperation(c511009065.desop)
	c:RegisterEffect(e2)
	
	--defence attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end

function c511009065.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511009065.descon(e,tp,eg,ep,ev,re,r,rp)
		return not Duel.IsExistingMatchingCard(c511009065.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c511009065.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511009065.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsOnField() and c511009065.filter2(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c511009065.filter2,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009065.filter2,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009065.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
		Duel.Damage(p,500,REASON_EFFECT)
	end
end