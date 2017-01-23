-- Black Wing
-- scripted by: UnknownGuest
function c810000054.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c810000054.cost)
	e1:SetCondition(c810000054.condition)
	e1:SetOperation(c810000054.activate)
	c:RegisterEffect(e1)
	-- destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetDescription(aux.Stringid(810000054,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c810000054.descost)
	e2:SetTarget(c810000054.destg)
	e2:SetOperation(c810000054.desop)
	c:RegisterEffect(e2)
end
function c810000054.rfilter(c)
	return c:IsSetCard(0x33) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c810000054.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000054.rfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c810000054.rfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c810000054.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:GetAttack()>=2000
end
function c810000054.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c810000054.costfilter(c)
	return c:IsSetCard(0x33) and c:IsAbleToRemoveAsCost()
end
function c810000054.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c810000054.costfilter,tp,LOCATION_GRAVE,0,1,nil) 
		and c:IsAbleToRemoveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c810000054.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c810000054.desfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c810000054.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c810000054.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000054.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c810000054.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c810000054.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
	end
end
