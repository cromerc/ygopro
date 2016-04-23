--除雪機関車ハッスル・ラッセル
function c108000001.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(108000001,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c108000001.spcon)
	e1:SetOperation(c108000001.spop)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c108000001.sumlimit)
	c:RegisterEffect(e2)
end
function c108000001.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
	and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_SZONE,0,1,nil)
end
function c108000001.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP) then
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_SZONE,0,nil)
		if sg:GetCount()==0 then return end
		Duel.BreakEffect()
		if Duel.Destroy(sg,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,sg:GetCount()*200,REASON_EFFECT)
		end		 
	end
end
function c108000001.sumlimit(e,c)
	return not c:IsRace(RACE_MACHINE)
end