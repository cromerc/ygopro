--スフィア・ボム球体時限爆弾
function c511002509.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001906,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002509.eqtg)
	e1:SetOperation(c511002509.eqop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511002509.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002509.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511002509.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511002509.eqlimit)
		c:RegisterEffect(e1)
		--destroy&damage
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(26302522,1))
		e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(c511002509.descon)
		e2:SetTarget(c511002509.destg)
		e2:SetOperation(c511002509.desop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	else
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
function c511002509.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511002509.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	ec:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
	if c:GetAttack()>=ec:GetAttack() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,c:GetAttack()-ec:GetAttack())
	else
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,ec:GetAttack()-c:GetAttack())
	end
end
function c511002509.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) or not ec or not ec:IsRelateToEffect(e) then return end
	if Duel.Destroy(c,REASON_EFFECT)>0 then
		if c:GetAttack()>=ec:GetAttack() then
			Duel.Destroy(ec,REASON_EFFECT)
			Duel.Damage(1-tp,c:GetAttack()-ec:GetAttack(),REASON_EFFECT)
		else
			Duel.Damage(tp,ec:GetAttack()-c:GetAttack(),REASON_EFFECT)
		end
	end
end
