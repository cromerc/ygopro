--Action Card - Nightmare Prey
function c95000125.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c95000125.condition)
	e1:SetTarget(c95000125.target)
	e1:SetOperation(c95000125.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000125.handcon)
	c:RegisterEffect(e2)
end
function c95000125.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000125.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:GetPreviousControler()==tp and bit.band(tc:GetBattlePosition(),POS_FACEUP)~=0
		and bc:IsRelateToBattle() and bc:IsControler(1-tp)
end
function c95000125.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local bc=Duel.GetAttacker()
	local bct=Duel.GetAttackTarget()
	if chk==0 then return bc:IsCanBeEffectTarget(e) and bc:IsDestructable() or bct:IsDestructable() end
	if bc:IsLocation(LOCATION_MZONE) then
	Duel.SetTargetCard(bc)
	else
	Duel.SetTargetCard(bct)
	end	
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	
end
function c95000125.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,700,REASON_EFFECT)
	end
end

