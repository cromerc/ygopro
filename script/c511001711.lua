--Performapal Landlord Hermit Crab
function c511001711.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001711,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c511001711.spcon)
	e2:SetTarget(c511001711.sptg)
	e2:SetOperation(c511001711.spop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetDescription(aux.Stringid(511001711,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCountLimit(1)
	e3:SetCondition(c511001711.atkcon)
	e3:SetOperation(c511001711.atkop)
	c:RegisterEffect(e3)
end
function c511001711.cfilter(c,tp)
	return c:IsType(TYPE_PENDULUM) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_EXTRA) 
		and c:GetPreviousControler()==tp
end
function c511001711.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001711.cfilter,1,nil,tp)
end
function c511001711.spfilter(c,e,tp)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001711.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511001711.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511001711.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511001711.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511001711.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001711.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and ((a:GetControler()==tp and a:IsRelateToBattle() and a:IsType(TYPE_PENDULUM))
		or (d:GetControler()==tp and d:IsRelateToBattle() and d:IsType(TYPE_PENDULUM)))
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>1
end
function c511001711.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if Duel.GetTurnPlayer()~=tp then a=Duel.GetAttackTarget() end
	if not a:IsRelateToBattle() then return end
	local atk=(Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)-1)*300
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(atk)
	a:RegisterEffect(e1)
end
