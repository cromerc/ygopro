--NO4 エーテリック・アヌビス
function c111011803.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--Search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(111011803,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DESTROY)
	e2:SetCost(c111011803.cost)
	e2:SetTarget(c111011803.sptg)
	e2:SetOperation(c111011803.spop)
	c:RegisterEffect(e2)
end
function c111011803.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c111011803.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tc:GetPreviousControler(),LOCATION_SZONE)>0 
	and eg:GetCount()==1 and tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_SPELL+TYPE_TRAP) and tc:GetPreviousControler()==tp
		and tc:IsSSetable() end
	tc:CreateEffectRelation(e)
end
function c111011803.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToEffect(e) then
		Duel.SSet(tp,tc)
		if tc:IsType(TYPE_TRAP) then
			tc:SetStatus(STATUS_SET_TURN,false)
		end
	end
end
