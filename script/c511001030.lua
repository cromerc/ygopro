--Butterfly Mist
function c511001030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63014935,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCondition(c511001030.damcon)
	e2:SetTarget(c511001030.damtg)
	e2:SetOperation(c511001030.damop)
	c:RegisterEffect(e2)
end
function c511001030.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x6a)
end
function c511001030.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and tp~=rp and bit.band(r,REASON_EFFECT)~=0
		and Duel.IsExistingMatchingCard(c511001030.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001030.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511001030.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
