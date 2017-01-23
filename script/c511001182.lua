--Neutrino Dowsing
function c511001182.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001182.con)
	e1:SetCost(c511001182.cost)
	e1:SetTarget(c511001182.target)
	e1:SetOperation(c511001182.activate)
	c:RegisterEffect(e1)
end
function c511001182.cfilter(c,tp)
	return c:IsType(TYPE_XYZ) and c:IsControler(1-tp)
end
function c511001182.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001182.cfilter,1,nil,tp)
end
function c511001182.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Group.CreateGroup()
	for i=0,4 do
		local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
		if tc and tc:IsFaceup() and tc:IsSetCard(0x107b) and tc:IsType(TYPE_XYZ) then
			g:Merge(tc:GetOverlayGroup())
		end
	end
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c511001182.filter(c)
	return c:GetType()==TYPE_SPELL and c:IsAbleToGrave() and c:CheckActivateEffect(false,true,false)~=nil
end
function c511001182.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001182.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c511001182.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001182.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local te,eg,ep,ev,re,r,rp=g:GetFirst():CheckActivateEffect(false,true,false)
		e:SetLabelObject(te)
		Duel.ClearTargetCard()
		local tg=te:GetTarget()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		local op=te:GetOperation()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
	end
end
