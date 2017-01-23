--Xyz Battle Chain
--scripted by:urielkama
function c511004106.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_CHAINING)
e1:SetCondition(c511004106.con)
e1:SetTarget(c511004106.tg)
e1:SetOperation(c511004106.op)
c:RegisterEffect(e1)
end
function c511004106.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511004106.cfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0 and c:GetAttackedCount()==0
end
function c511004106.con(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	if not (re:IsActiveType(TYPE_SPELL) or re:IsActiveType(TYPE_TRAP)) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c511004106.cfilter,1,nil) and Duel.IsChainNegatable(ev) and Duel.IsExistingMatchingCard(c511004106.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c511004106.filter,tp,0,LOCATION_MZONE,1,nil)
end
function c511004106.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004106.filter,tp,LOCATION_MZONE,0,1,nil) and not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_SKIP_M2) end
	local g=Duel.SelectTarget(tp,c511004106.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511004106.op(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then 
		if tc and tc:IsRelateToEffect(e) and Duel.Destroy(eg,REASON_EFFECT)~=0 and Duel.GetTurnPlayer()~=tp  and not (Duel.IsAbleToEnterBP() or (Duel.GetCurrentPhase()==PHASE_BATTLE_START and Duel.GetCurrentPhase()==PHASE_BATTLE)) then
		local g=Duel.GetMatchingGroup(c511004106.cfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,nil)
			if g:GetCount()>0 then
			local sg=g:Select(Duel.GetTurnPlayer(),1,1,nil)
			Duel.HintSelection(sg)
			Duel.CalculateDamage(sg:GetFirst(),tc)
	    	if tc:IsStatus(STATUS_BATTLE_DESTROYED) then
		     	Duel.Destroy(tc,REASON_BATTLE)
		        end
	else Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
	    Duel.Destroy(eg,REASON_EFFECT)
			  	end
		  	end
	  	end
  	end
end