--Lightning Talisman
function c511000665.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000665.condition)
	e1:SetTarget(c511000665.target)
	e1:SetOperation(c511000665.activate)
	c:RegisterEffect(e1)
end
function c511000665.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000665.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c511000665.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		if Duel.NegateAttack(tc) then
			Duel.Draw(p,1,REASON_EFFECT)
			local dam=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)*400
			Duel.Damage(p,dam,REASON_EFFECT)
		end
	end
end
