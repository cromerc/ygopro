--Strain Bomb
function c511002522.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetDescription(aux.Stringid(511001942,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c511002522.destg)
	e1:SetOperation(c511002522.desop)
	c:RegisterEffect(e1)
end
function c511002522.filter(c)
	return (c:IsCode(511002522) or c:IsCode(511002160)) and c:IsFaceup()
end
function c511002522.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(c511002522.filter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	if sg:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2000)
	end
end
function c511002522.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511002522.filter,tp,LOCATION_ONFIELD,0,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,2000,REASON_EFFECT)
	end
end
