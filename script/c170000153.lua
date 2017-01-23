--Claw of Hermos
function c170000153.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c170000153.target)
	e1:SetOperation(c170000153.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c170000153.monval)
	c:RegisterEffect(e2)
end
function c170000153.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
		and Duel.IsExistingMatchingCard(c170000153.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c170000153.spfilter(c,e,tp)
	local f=c.hermos_filter
	if not f then return false end
	return Duel.IsExistingMatchingCard(c170000153.tgfilter,tp,LOCATION_MZONE,0,1,nil,f)
end
function c170000153.tgfilter(c,f)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and f(c)
		and Duel.IsExistingTarget(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c170000153.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<-1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c170000153.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=sg:GetFirst()
	if sc then
		local f=sc.hermos_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=Duel.SelectMatchingCard(tp,c170000153.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,f)
		tg:AddCard(e:GetHandler())
		Duel.SendtoGrave(tg,REASON_EFFECT)
		Duel.BreakEffect()
		if sc:CheckActivateEffect(false,false,false)~=nil then
			Duel.MoveToField(sc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local tpe=sc:GetType()
			local te=sc:GetActivateEffect()
			local tg=te:GetTarget()
			local co=te:GetCost()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			Duel.Hint(HINT_CARD,0,sc:GetCode())
			sc:CreateEffectRelation(te)
			if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			if op then op(te,tp,eg,ep,ev,re,r,rp) end
			sc:ReleaseEffectRelation(te)
		else
			Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
		end
		sc:CompleteProcedure()
	end
end
function c170000153.monval(e,c)
	if (c:IsOnField() and c:IsFacedown()) or c:IsLocation(LOCATION_GRAVE) then
		return TYPE_EFFECT+TYPE_MONSTER
	else
		return 0
	end
end
