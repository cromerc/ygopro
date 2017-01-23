--Illegal Keeper
--scripted by GameMaster (GM)
function c511005629.initial_effect(c)
	--Return cards to deck & inflict 1000 per card returned
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3167573,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c511005629.condition)
	e1:SetTarget(c511005629.target)
	e1:SetOperation(c511005629.activate)
	c:RegisterEffect(e1)
end
function c511005629.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and ep~=tp and Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c511005629.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511005629.cfilter,1,nil,1-tp)
end
function c511005629.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c511005629.filter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c511005629.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(c511005629.filter,nil,e,1-tp)
	local ct=Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
end
		