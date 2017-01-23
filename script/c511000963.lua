--Dromi the Sacred Shackles
function c511000963.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511000963.condition)
	e1:SetTarget(c511000963.target)
	e1:SetOperation(c511000963.activate)
	c:RegisterEffect(e1)
end
function c511000963.cfilter(c,tp)
	return c:IsFaceup() and c:IsPreviousLocation(LOCATION_MZONE+LOCATION_GRAVE) and c:GetPreviousControler()~=tp
		and c:IsType(TYPE_MONSTER)
end
function c511000963.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000963.cfilter,1,nil,tp) and eg:GetCount()==1
end
function c511000963.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b)
end
function c511000963.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000963.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000963.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000963.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local dam=0
	if g:GetFirst():GetAttack()>tc:GetAttack() then
		dam=g:GetFirst():GetAttack()-tc:GetAttack()
	else
		dam=tc:GetAttack()-g:GetFirst():GetAttack()
	end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511000963.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
