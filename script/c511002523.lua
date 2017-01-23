--ヘル・テンペスト
function c511002523.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002523.condition)
	e1:SetTarget(c511002523.target)
	e1:SetOperation(c511002523.activate)
	c:RegisterEffect(e1)
end
function c511002523.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and ev>=4000
end
function c511002523.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511002523.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002523.filter,tp,LOCATION_DECK+LOCATION_GRAVE,LOCATION_DECK+LOCATION_GRAVE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511002523.filter,tp,LOCATION_DECK+LOCATION_GRAVE,LOCATION_DECK+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c511002523.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511002523.filter,tp,LOCATION_DECK+LOCATION_GRAVE,LOCATION_DECK+LOCATION_GRAVE,nil)
	if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)>0 then
		local g=sg:Filter(Card.IsLocation,nil,LOCATION_REMOVED)
		g:KeepAlive()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e2:SetCode(EFFECT_FORBIDDEN)
		e2:SetTargetRange(0x7f,0x7f)
		e2:SetTarget(c511002523.bantg)
		e2:SetLabelObject(g)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetCode(EFFECT_DISABLE)
		e3:SetTargetRange(0x7f,0x7f)
		e3:SetTarget(c511002523.bantg)
		e3:SetLabelObject(g)
		Duel.RegisterEffect(e3,tp)
	end
end
function c511002523.bantg(e,c)
	return (not c:IsOnField() or c:GetRealFieldID()>e:GetFieldID()) and e:GetLabelObject():IsContains(c)
end
