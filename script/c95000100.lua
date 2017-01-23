--Action Card - Underworld Evasion
function c95000100.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95000100,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c95000100.condition)
	e1:SetTarget(c95000100.sptg)
	e1:SetOperation(c95000100.spop)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000100.handcon)
	c:RegisterEffect(e2)
end
function c95000100.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()~=nil and Duel.GetTurnPlayer()~=tp
end
function c95000100.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c95000100.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,95000101,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,95000101)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_BE_BATTLE_TARGET)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetOperation(c95000100.atkop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1,true)
end

function c95000100.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end

function c95000100.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end