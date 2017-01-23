--Blue-Eyes Tyrant Dragon
function c170000156.initial_effect(c)
   	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,58293343,89631139,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c170000156.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c170000156.spcon)
	e2:SetOperation(c170000156.spop)
	c:RegisterEffect(e2)
  	--All Attack
   	local e3=Effect.CreateEffect(c)
   	e3:SetType(EFFECT_TYPE_SINGLE)
   	e3:SetCode(EFFECT_ATTACK_ALL)
   	e3:SetValue(1)
   	c:RegisterEffect(e3)
end
function c170000156.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c170000156.spfilter(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c170000156.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,nil,58293343)
		and Duel.IsExistingMatchingCard(c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,nil,89631139)
end
function c170000156.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,58293343)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,89631139)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
