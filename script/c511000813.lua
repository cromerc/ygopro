--Signal Vehicle
function c511000813.initial_effect(c)
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000813,0))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000813.atkcon)
	e2:SetTarget(c511000813.atktg)
	e2:SetOperation(c511000813.atkop)
	c:RegisterEffect(e2)
end
function c511000813.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000813.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c511000813.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD,nil)
end
