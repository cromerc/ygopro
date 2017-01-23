--Reversal Sword
function c511000946.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511000946.target)
	e1:SetOperation(c511000946.operation)
	c:RegisterEffect(e1)
end
function c511000946.cfilter(c,tp)
	local lv=c:GetLevel()
	return c:IsControler(1-tp) and c:IsReason(REASON_BATTLE) and lv>0
		and Duel.IsExistingTarget(c511000946.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,lv) 
end
function c511000946.filter(c,lv)
	return c:GetLevel()<lv and c:IsFaceup() and c:IsDestructable()
end
function c511000946.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return eg:IsExists(c511000946.cfilter,1,nil,tp) end
	local tc=eg:Filter(c511000946.cfilter,nil,tp):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511000946.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tc:GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511000946.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT,true)
			Duel.Damage(tp,atk,REASON_EFFECT,true)
			Duel.RDComplete()
		end
	end
end
