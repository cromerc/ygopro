--Future Battle
function c511000782.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Battle
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(511000782,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511000782.condition)
	e2:SetTarget(c511000782.target)
	e2:SetOperation(c511000782.operation)
	c:RegisterEffect(e2)
end
function c511000782.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE and Duel.GetTurnPlayer()==tp 
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000782.filter(c)
	return c:IsAttackPos() and c:IsFaceup()
end
function c511000782.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and c511000782.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000782.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000782.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000782.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.DisableShuffleCheck()
		Duel.ConfirmDecktop(1-tp,1)
		local g=Duel.GetDecktopGroup(1-tp,1)
		local tt=g:GetFirst()
		if tt:IsType(TYPE_MONSTER) then
			if tt:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
				Duel.SpecialSummon(tt,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
				Duel.CalculateDamage(tc,tt)
				if tt:IsStatus(STATUS_BATTLE_DESTROYED) then
					e:SetCountLimit(1)
				end
			end
		else
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
