--クリアウィング・シンクロ・ドラゴン
function c5500.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5500,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c5500.condition1)
	e1:SetTarget(c5500.target)
	e1:SetOperation(c5500.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e1:SetDescription(aux.Stringid(5500,1))
	e1:SetCondition(c5500.condition2)
	c:RegisterEffect(e2)
end
function c5500.condition1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsActiveType(TYPE_MONSTER) then return false end
	local rc=re:GetHandler()
	return Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE and Duel.IsChainNegatable(ev)
		and rc~=e:GetHandler() and rc:IsLevelAbove(5)
end
function c5500.condition2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) or not re:IsActiveType(TYPE_MONSTER) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local tc=tg:GetFirst()
	return tg and tg:GetCount()==1 and tc:IsOnField() and tc:IsLevelAbove(5) and Duel.IsChainNegatable(ev)
end
function c5500.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c5500.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			local dg=Duel.GetOperatedGroup()
			local atk=0
			local dc=dg:GetFirst()
			while dc do
				if dc:GetBaseAttack()>0 then atk=atk+dc:GetBaseAttack() end
				dc=dg:GetNext()
			end
			if atk>0 then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_UPDATE_ATTACK)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				e1:SetValue(atk)
				c:RegisterEffect(e1)
			end
		end
	end
end
