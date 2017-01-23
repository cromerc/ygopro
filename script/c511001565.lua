--Performage Mirror Conductor
function c511001565.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--lowest value
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c511001565.target)
	e1:SetValue(c511001565.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	c:RegisterEffect(e2)
	--switch
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001565,0))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c511001565.con)
	e3:SetTarget(c511001565.tg)
	e3:SetOperation(c511001565.op)
	c:RegisterEffect(e3)
end
function c511001565.val(e,c)
	if c:GetBaseAttack()<=c:GetBaseDefense() then
		return c:GetBaseAttack()
	else
		return c:GetBaseDefense()
	end
end
function c511001565.target(e,c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0
end
function c511001565.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc
end
function c511001565.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local bc=e:GetHandler():GetBattleTarget()
	if chkc then return chkc==bc end
	if chk==0 then return bc:IsOnField() and bc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(bc)
end
function c511001565.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(def)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
	end
end
