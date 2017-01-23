--Black Feather Cursed Guard
function c511002795.initial_effect(c)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000995,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511002795.condition)
	e2:SetTarget(c511002795.target)
	e2:SetOperation(c511002795.activate)
	c:RegisterEffect(e2)
end
function c511002795.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg or tg:GetCount()~=1 or not tg:GetFirst():IsSetCard(0x33) or not tg:GetFirst():IsLocation(LOCATION_MZONE) 
		or tg:GetFirst():IsControler(1-tp) then return false end
	return rp~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c511002795.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local tc=tg:GetFirst()
	if chk==0 then return tc and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511002795.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		Duel.NegateEffect(ev)
		--destroy replace
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetRange(LOCATION_SZONE)
		e1:SetTarget(c511002795.destg)
		e1:SetValue(c511002795.desval)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c511002795.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if chk==0 then return tc and eg:IsContains(tc) and tc:GetAttack()>=400 and tc:GetLevel()>1 end
	if Duel.SelectYesNo(tp,aux.Stringid(511002795,0)) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-400)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_LEVEL)
		e2:SetValue(-1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		return true
	else return false
	end
end
function c511002795.desval(e,c)
	return c==e:GetHandler():GetFirstCardTarget()
end
