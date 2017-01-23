--Return Marker
function c511000831.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511000831.condition)
	e1:SetTarget(c511000831.target)
	e1:SetOperation(c511000831.activate)
	c:RegisterEffect(e1)
end
function c511000831.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	if re:IsHasCategory(CATEGORY_NEGATE)
		and Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ep==tp then return false end
	local ex2,cg2,ct2,cp2,cv2=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex2 and (cp2==tp or cp2==PLAYER_ALL) then return true end
	ex2,cg2,ct2,cp2,cv2=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ((ex2 and (cp2==tp or cp2==PLAYER_ALL) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER))
		or (ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0)) 
		and ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c511000831.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,eg:GetFirst(),0,tp,eg:GetFirst():GetAttack())
	end
end
function c511000831.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Damage(1-tp,eg:GetFirst():GetAttack(),REASON_EFFECT)
	end
end
