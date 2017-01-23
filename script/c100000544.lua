--超巨大不沈客船エレガントタイタニック
function c100000544.initial_effect(c)
	--special summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c100000544.spcon)
    e1:SetOperation(c100000544.spop)
    c:RegisterEffect(e1)
	--destroy&damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c100000544.target)
	e2:SetOperation(c100000544.operation)
	c:RegisterEffect(e2)
end
function c100000544.spcon(e,c)
	if c==nil then return true end
    return Duel.CheckReleaseGroup(c:GetControler(),Card.IsType,2,nil,TYPE_TOKEN)
end
function c100000544.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,2,2,nil,TYPE_TOKEN)
    Duel.Release(g,REASON_COST)
end
function c100000544.filter(c)
	return c:IsFaceup() and c:IsDestructable() and c:GetDefense()==0
end
function c100000544.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100000544.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000544.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100000544.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,g:GetFirst():GetTextAttack())
end
function c100000544.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(1-tp) then
		local atk=tc:GetAttack()
		if atk<0 then atk=0 end
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk/2,REASON_EFFECT)
		end
	end
end

