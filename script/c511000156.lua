-- Laplace the Fiend Mathematician
-- Scripted by UnknownGuest
function c511000156.initial_effect(c)
	-- Inflict Damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000156,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000156.damtg)
	e1:SetOperation(c511000156.damop)
	c:RegisterEffect(e1)
end
function c511000156.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,0xc,0xc)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c511000156.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,0xc,0xc)
	Duel.Damage(p,ct*300,REASON_EFFECT)
end