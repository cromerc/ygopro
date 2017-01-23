--Solidroid beta
function c511002245.initial_effect(c)
	aux.AddFusionProcCode3(c,98049038,511002240,511000660,false,false)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511002245.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511002245.spcon)
	e2:SetOperation(c511002245.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(16304628,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c511002245.destg)
	e3:SetOperation(c511002245.desop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
function c511002245.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c511002245.spfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511002245.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	local g1=Duel.GetMatchingGroup(c511002245.spfilter,tp,LOCATION_GRAVE,0,nil,98049038)
	local g2=Duel.GetMatchingGroup(c511002245.spfilter,tp,LOCATION_GRAVE,0,nil,511002240)
	local g3=Duel.GetMatchingGroup(c511002245.spfilter,tp,LOCATION_GRAVE,0,nil,511000660)
	if g1:GetCount()==0 or g2:GetCount()==0 or g3:GetCount()==0 then return false end
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c511002245.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(c511002245.spfilter,tp,LOCATION_GRAVE,0,nil,98049038)
	local g2=Duel.GetMatchingGroup(c511002245.spfilter,tp,LOCATION_GRAVE,0,nil,511002240)
	local g3=Duel.GetMatchingGroup(c511002245.spfilter,tp,LOCATION_GRAVE,0,nil,511000660)
	g1:Merge(g2)
	g1:Merge(g3)
	local g=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local tc=g1:Select(tp,1,1,nil):GetFirst()
		g:AddCard(tc)
		g1:Remove(Card.IsCode,nil,tc:GetCode())
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511002245.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002245.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
