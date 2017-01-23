--Star Seraph Starscream
function c511001061.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511001061.condition)
	e1:SetTarget(c511001061.target)
	e1:SetOperation(c511001061.activate)
	c:RegisterEffect(e1)
end
function c511001061.cfilter(c,tp)
	return c:GetPreviousControler()==1-tp and c:IsType(TYPE_MONSTER)
end
function c511001061.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x86)
end
function c511001061.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001061.cfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c511001061.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511001061.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
