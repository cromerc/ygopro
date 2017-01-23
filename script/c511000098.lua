--Double Tribute
function c511000098.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511000098.condition)
	e1:SetTarget(c511000098.target)
	e1:SetOperation(c511000098.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c511000098.cfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c511000098.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000098.cfilter,nil,tp)
	if g:GetCount()~=1 then return end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil)
end
function c511000098.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if not eg then return false end
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 then return ep==tp and tc:IsFaceup() and tc:IsOnField() and tc:IsCanBeEffectTarget(e)
	 and tc:IsDestructable() end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c511000098.filter(c)
	return c:IsDestructable()
end
function c511000098.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			local g=Duel.SelectTarget(tp,c511000098.filter,tp,0,LOCATION_MZONE,1,1,nil)
			local tc2=g:GetFirst()
			Duel.Destroy(tc2,REASON_EFFECT)
		end
	end
end
