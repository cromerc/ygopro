--D/D Pandora
function c511001041.initial_effect(c)
	--draw 2
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001041,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511001041.condition)
	e1:SetTarget(c511001041.target)
	e1:SetOperation(c511001041.operation)
	c:RegisterEffect(e1)
end
function c511001041.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():GetPreviousControler()==tp
		and e:GetHandler():IsReason(REASON_DESTROY) and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0
end
function c511001041.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511001041.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
