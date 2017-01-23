--D/D/D Kali Yuga the Twin Dawn Overlord (Anime)
function c511001376.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xaf),8,2)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CANNOT_DISEFFECT)
	c:RegisterEffect(e0)
	--cannot disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001376,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c511001376.negop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001376,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c511001376.descost)
	e3:SetTarget(c511001376.destg)
	e3:SetOperation(c511001376.desop)
	c:RegisterEffect(e3)
	--return
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511001376.retcon)
	e4:SetCost(c511001376.descost)
	e4:SetTarget(c511001376.rettg)
	e4:SetOperation(c511001376.retop)
	c:RegisterEffect(e4)
end
function c511001376.negop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c511001376.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001376.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511001376.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001376.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c511001376.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511001376.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001376.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511001376.retcfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp and c:IsControler(tp)
		and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511001376.retcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c511001376.retcfilter,1,nil,tp) and re and re:GetHandler()==e:GetHandler()
end
function c511001376.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511001376.retcfilter,nil,tp)
	local gm=g:Filter(Card.IsPreviousLocation,nil,LOCATION_MZONE)
	local gst=g:Filter(Card.IsPreviousLocation,nil,LOCATION_SZONE)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>gm:GetCount()-1 
		or Duel.GetLocationCount(tp,LOCATION_SZONE)>gst:GetCount()-1 end
	Duel.SetTargetCard(g)
end
function c511001376.retop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	if not g or g:GetCount()<=0 then return end
	local gm=g:Filter(Card.IsPreviousLocation,nil,LOCATION_MZONE)
	local gst=g:Filter(Card.IsPreviousLocation,nil,LOCATION_SZONE)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>gm:GetCount()-1 then
		local tc=gm:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,tc:GetPreviousLocation(),tc:GetPreviousPosition(),true)
			tc=gm:GetNext()
		end
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>gst:GetCount()-1 then
		local tc=gst:GetFirst()
		while tc do
			if tc:IsPreviousPosition(POS_FACEDOWN) and tc:IsSSetable() then
				Duel.SSet(tp,tc)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
				e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
			else
				Duel.MoveToField(tc,tp,tp,tc:GetPreviousLocation(),tc:GetPreviousPosition(),true)
				if tc:IsFacedown() then
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
					e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
					e1:SetReset(RESET_EVENT+0x1fe0000)
					tc:RegisterEffect(e1)
				end
			end
			tc=gst:GetNext()
		end
	end
end
