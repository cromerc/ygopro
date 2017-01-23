--レッド・ワイバーン
function c511001964.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100024,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001964.descon)
	e1:SetTarget(c511001964.destg)
	e1:SetOperation(c511001964.desop)
	c:RegisterEffect(e1)
end
function c511001964.cfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511001964.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001964.cfilter,tp,0,LOCATION_MZONE,2,nil,e:GetHandler():GetAttack()) 
		and Duel.GetTurnPlayer()~=tp
end
function c511001964.filter(c,tp)
	local atk=c:GetAttack()
	return c:IsFaceup() and c:IsDestructable() 
		and not Duel.IsExistingMatchingCard(c511001964.cfilter,tp,0,LOCATION_MZONE,1,nil,atk)
end
function c511001964.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511001964.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001964.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001964.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001964.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsControler(1-tp) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
