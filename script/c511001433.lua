--運命の扉
function c511001433.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001433.condition)
	e1:SetTarget(c511001433.target)
	e1:SetOperation(c511001433.activate)
	c:RegisterEffect(e1)
end
function c511001433.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511001433.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001433,0,0x21,0,0,1,RACE_FIEND,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001433.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateAttack() then return end
	Duel.BreakEffect()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001433,0,0x21,0,0,1,RACE_FIEND,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_EFFECT)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27062594,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCondition(c511001433.damcon)
	e1:SetTarget(c511001433.damtg)
	e1:SetOperation(c511001433.damop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511001433.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001433.cfilter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c:IsAbleToRemove()
end
function c511001433.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001433.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511001433.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001433.cfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:Select(tp,1,g:GetCount(),nil)
	if sg:GetCount()>0 then
		local ct=Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		local val=Duel.Damage(1-tp,ct*500,REASON_EFFECT)
		local c=e:GetHandler()
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(val)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
		end
	end
end
