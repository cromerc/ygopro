--奈落に蠢く者
function c100000188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000188.condition)
	e1:SetTarget(c100000188.target)
	e1:SetOperation(c100000188.activate)
	c:RegisterEffect(e1)
end
function c100000188.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetAttack()>=2000 and tp~=Duel.GetTurnPlayer()
end
function c100000188.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local dam=tg:GetAttack()
	Duel.SetTargetParam(dam/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam/2)
end
function c100000188.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg,d=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS,CHAININFO_TARGET_PARAM)
	local tc=tg:GetFirst()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		if Duel.NegateAttack() then
			Duel.Damage(1-tp,d,REASON_EFFECT)
		end
	end
end
