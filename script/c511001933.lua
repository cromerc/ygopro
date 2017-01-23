--Wicked Rune - Sadness
function c511001933.initial_effect(c)
	--banish
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetDescription(aux.Stringid(511001933,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c511001933.bantg)
	e1:SetOperation(c511001933.banop)
	c:RegisterEffect(e1)
end
function c511001933.filter(c,code)
	return c:IsCode(code) and c:IsAbleToRemove()
end
function c511001933.bantg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511001933.filter,tp,LOCATION_GRAVE,0,e:GetHandler(),e:GetHandler():GetCode())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511001933.banop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001933.filter,tp,LOCATION_GRAVE,0,e:GetHandler(),e:GetHandler():GetCode())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
