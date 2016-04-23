---死の代行者 ウラヌス
function c501001036.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c501001036.ssrcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001036,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c501001036.target)
	e2:SetOperation(c501001036.operation)
	c:RegisterEffect(e2)
end
function c501001036.ssrfilter(c)
	return c:IsFaceup()
	and c:IsCode(56433456)
end
function c501001036.ssrcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c501001036.ssrfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c501001036.filter(c)
	return c:IsAbleToGrave()
	and c:IsSetCard(0x44)
end
function c501001036.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001036.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end	
function c501001036.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001036.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 then
			local lv=tc:GetLevel()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e1)
		end
	end
end	
