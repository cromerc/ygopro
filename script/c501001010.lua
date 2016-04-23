---ＥＭビックリカエル
function c501001010.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001010,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c501001010.adcon)
	e2:SetTarget(c501001010.adtg1)
	e2:SetOperation(c501001010.adop1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(501001010,1))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c501001010.adtg2)
	e3:SetOperation(c501001010.adop2)
	c:RegisterEffect(e3)
end	
function c501001010.adcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return (c:GetSequence()==6 or c:GetSequence()==7)
end
function c501001010.filter1(c)
	return c:IsFaceup()
	and c:GetAttack()~=c:GetDefence()
end
function c501001010.adtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c501001010.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.SelectTarget(tp,c501001010.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	Duel.SetOperationInfo(tp,CATEGORY_ATKCHANGE,tc,1,tp,tc:GetDefence())
	Duel.SetOperationInfo(tp,CATEGORY_DEFCHANGE,tc,1,tp,tc:GetAttack())
end	
function c501001010.adop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		local def=tc:GetDefence()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENCE_FINAL)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e2)
	end
end	
function c501001010.filter2(c)
	return (c:IsFaceup() and c:GetAttack()~=c:GetDefence())
	or c:IsFacedown()
end
function c501001010.adtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c501001010.filter2,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c501001010.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	Duel.SetOperationInfo(tp,CATEGORY_ATKCHANGE,tc,1,tp,tc:GetDefence())
	Duel.SetOperationInfo(tp,CATEGORY_DEFCHANGE,tc,1,tp,tc:GetAttack())
end	
function c501001010.adop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:IsAttackPos()then
			Duel.ChangePosition(tc,POS_FACEUP_DEFENCE)
		else
			Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
		end
		local atk=tc:GetAttack()
		local def=tc:GetDefence()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENCE_FINAL)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e2)
	end
end	
