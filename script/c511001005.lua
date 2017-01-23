--Extinction Fist
function c511001005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001005.condition)
	e1:SetTarget(c511001005.target)
	e1:SetOperation(c511001005.activate)
	c:RegisterEffect(e1)
end
function c511001005.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==nil
end
function c511001005.atkfilter(c,e)
	return c:IsDestructable() and (c:IsType(TYPE_RITUAL) or c:IsType(TYPE_FUSION))
end
function c511001005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511001005.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local op=1-tp
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			local mg=tc:GetMaterial()
			if mg:IsExists(c511001005.mgfilter,1,nil,e,op,tc) then
				local ft=Duel.GetLocationCount(op,LOCATION_MZONE)
				if ft>0 then
					local g=mg:FilterSelect(op,c511001005.mgfilter,ft,ft,nil,e,op,tc)
					Duel.SpecialSummon(g,0,op,op,false,false,POS_FACEUP)
				end
				Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
			end
		end
	end
end
function c511001005.mgfilter(c,e,tp,tc)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
