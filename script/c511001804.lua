--Dummy Marker
function c511001804.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(983995,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511001804.drcon)
	e1:SetTarget(c511001804.drtg)
	e1:SetOperation(c511001804.drop)
	c:RegisterEffect(e1)
end
function c511001804.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD) 
		and c:IsPreviousPosition(POS_FACEDOWN)
end
function c511001804.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dr=1
	if rp~=tp and re:IsActiveType(TYPE_SPELL) then dr=2 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(dr)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,dr)
end
function c511001804.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
