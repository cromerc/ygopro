--White Warrior - Fog the Treasure Shield
function c511001978.initial_effect(c)
	--destroy s/t
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100039,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511001978.descon)
	e1:SetTarget(c511001978.destg)
	e1:SetOperation(c511001978.desop)
	c:RegisterEffect(e1)
end
function c511001978.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():IsControler(tp) and Duel.GetAttackTarget()==nil and e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c511001978.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511001978.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511001978.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001978.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511001978.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001978.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
