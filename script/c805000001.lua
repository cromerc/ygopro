--DZW－魔装鵺妖衣
function c805000001.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000001,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c805000001.eqtg)
	e1:SetOperation(c805000001.eqop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c805000001.retcon)
	e3:SetTarget(c805000001.rettg)
	e3:SetOperation(c805000001.retop)
	c:RegisterEffect(e3)
end
function c805000001.filter(c)
	return c:IsFaceup() and (c:IsCode(66970002) or c:IsCode(56840427) or c:IsCode(805000048))
end
function c805000001.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c805000001.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c805000001.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c805000001.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c805000001.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c805000001.eqlimit)
	c:RegisterEffect(e1)
end
function c805000001.eqlimit(e,c)
	return c:IsCode(66970002) or c:IsCode(56840427) or c:IsCode(805000048)
end
function c805000001.retcon(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():GetEquipTarget():IsRelateToBattle() then return false end
	local t=nil
	if ev==0 then t=Duel.GetAttackTarget()
	else return false end
	e:SetLabelObject(t)
	return t and t:IsRelateToBattle() and t:GetAttack()>0 and Duel.GetAttacker()==e:GetHandler():GetEquipTarget()
end
function c805000001.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,e:GetLabelObject(),1,0,0)
end
function c805000001.retop(e,tp,eg,ep,ev,re,r,rp)
	tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.CalculateDamage(e:GetHandler():GetEquipTarget(),tc)
	end
end