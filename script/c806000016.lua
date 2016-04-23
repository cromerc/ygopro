--ゴーストリック・ランタン
function c806000016.initial_effect(c)
	--sumlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c806000016.excon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c806000016.target)
	e2:SetOperation(c806000016.operation)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c806000016.spcon)
	e3:SetTarget(c806000016.sptg)
	e3:SetOperation(c806000016.spop)
	c:RegisterEffect(e3)
end
function c806000016.exfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8c)
end
function c806000016.excon(e)
	return not Duel.IsExistingMatchingCard(c806000016.exfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c806000016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(806000016)==0 end
	c:RegisterFlagEffect(806000016,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c806000016.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENCE)
	end
end
function c806000016.spcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttackTarget()==nil or (Duel.GetAttackTarget():IsSetCard(0x8c) and Duel.GetAttackTarget():IsFaceup()))
	 and Duel.GetAttacker():IsControler(1-tp)
end
function c806000016.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c806000016.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.NegateAttack(tc) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)
	end
end