--Abyss Ruler Mictlancoatl
function c511001690.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001690.spcon)
	e1:SetOperation(c511001690.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85103922,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511001690.destg)
	e2:SetOperation(c511001690.desop)
	c:RegisterEffect(e2)
end
function c511001690.spfilter(c)
	return (c:IsSetCard(0xec) or c:IsSetCard(0xb1) or c:IsSetCard(0x75) or c:IsSetCard(0x74) or c:IsCode(87303357) or c:IsCode(53375573) 
		or c:IsCode(40387124) or c:IsCode(74069667) or c:IsCode(29424328) or c:IsCode(86442081) or c:IsCode(18318842) or c:IsCode(88409165) 
		or c:IsCode(44223284) or c:IsCode(84478195) or c:IsCode(67111213) or c:IsCode(9753964) or c:IsCode(96864105) or c:IsCode(36076683)
		or c:IsCode(21044178) or c:IsCode(97232518)) and c:IsAbleToRemoveAsCost()
end
function c511001690.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001690.spfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c511001690.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c511001690.spfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c511001690.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511001690.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001690.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c511001690.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c511001690.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511001690.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Damage(1-tp,600,REASON_EFFECT)
	end
end
