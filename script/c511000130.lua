--Volcanic Curse
function c511000130.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511000130.condition)
	e1:SetTarget(c511000130.target)
	e1:SetOperation(c511000130.activate)
	c:RegisterEffect(e1)
end

function c511000130.condition(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetAttackTarget()
	return t and t:IsControler(tp) and t:IsSetCard(0x32)
end
function c511000130.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttackTarget()
	if chkc then return chkc==tg end
	if chk==0 then return Duel.GetAttacker():IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c511000130.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(c511000130.val)
		tc:RegisterEffect(e1)
	end
end

function c511000130.atkfilter(c)
	return c:IsRace(RACE_PYRO)
end
function c511000130.val(e,c)
	return Duel.GetMatchingGroupCount(c511000130.atkfilter,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)*500
end
