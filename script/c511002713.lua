--Earthbound Disciple Geo Griffon
function c511002713.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c511002713.sfilter,aux.NonTuner(c511002713.sfilter),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002713.descon)
	e1:SetTarget(c511002713.destg)
	e1:SetOperation(c511002713.desop)
	c:RegisterEffect(e1)
	--destroy (when self is destroyed)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c511002713.descon2)
	e2:SetTarget(c511002713.destg)
	e2:SetOperation(c511002713.desop)
	c:RegisterEffect(e2)
end
function c511002713.sfilter(c)
	return c:IsSetCard(0x21f) or c:IsSetCard(0x21) or c:IsCode(67105242) or c:IsCode(67987302)
end
function c511002713.cfilter(c,tp)
	return c511002713.sfilter(c) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511002713.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002713.cfilter,1,nil,tp)
end
function c511002713.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002713.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511002713.descon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
		and (c:IsPreviousSetCard(0x21f) or c:IsPreviousSetCard(0x21) or c:GetPreviousCodeOnField()==67105242 or c:GetPreviousCodeOnField()==67987302)
end
