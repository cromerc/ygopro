--Rough Fight
function c511002097.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69764158,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511002097.damcon)
	e1:SetCost(c511002097.damcost)
	e1:SetTarget(c511002097.damtg)
	e1:SetOperation(c511002097.damop)
	c:RegisterEffect(e1)
end
function c511002097.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCode(511009200)
end
function c511002097.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.IsExistingMatchingCard(c511002097.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511002097.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511002097.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ev)
end
function c511002097.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
