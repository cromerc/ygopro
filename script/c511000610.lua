--Shadow Moon
function c511000610.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000610.cost)
	e1:SetTarget(c511000610.target)
	e1:SetOperation(c511000610.operation)
	c:RegisterEffect(e1)
	if not c511000610.global_check then
		c511000610.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511000610.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000610.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511000610.cfilter1(c)
	return c:GetLevel()>=5 and c:IsAbleToGraveAsCost() and Duel.IsExistingMatchingCard(c511000610.cfilter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,c:GetAttribute())
end
function c511000610.cfilter2(c,att1)
	return c:GetLevel()>=5 and c:IsAbleToGraveAsCost() and c:GetAttribute()~=att1 
	and Duel.IsExistingMatchingCard(c511000610.cfilter3,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,att1,c:GetAttribute())
end
function c511000610.cfilter3(c,att1,att2)
	return c:GetLevel()>=5 and c:IsAbleToGraveAsCost() and c:GetAttribute()~=att1 and c:GetAttribute()~=att2
	and Duel.IsExistingMatchingCard(c511000610.cfilter4,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,att1,att2,c:GetAttribute())
end
function c511000610.cfilter4(c,att1,att2,att3)
	return c:GetLevel()>=5 and c:IsAbleToGraveAsCost() and c:GetAttribute()~=att1 and c:GetAttribute()~=att2 and c:GetAttribute()~=att3
end
function c511000610.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000610.cfilter1,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511000610.cfilter1,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	local at1=g1:GetFirst():GetAttribute()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511000610.cfilter2,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,at1)
	local at2=g2:GetFirst():GetAttribute()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g3=Duel.SelectMatchingCard(tp,c511000610.cfilter3,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,at1,at2)
	local at3=g3:GetFirst():GetAttribute()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g4=Duel.SelectMatchingCard(tp,c511000610.cfilter4,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,at1,at2,at3)
	g1:Merge(g2)
	g1:Merge(g3)
	g1:Merge(g4)
	if g1:GetCount()~=4 then return end
	Duel.SendtoGrave(g1,REASON_COST)
end
function c511000610.filter(c)
	return c:IsCode(511000607) and c:CheckActivateEffect(true,true,false)~=nil
end
function c511000610.spfilter(c,e,tp)
	return c:IsCode(511000609) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000610.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000610.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil) 
	and Duel.IsExistingMatchingCard(c511000610.spfilter,tp,0x11,0,1,nil,e,tp) end
end
function c511000610.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.SelectMatchingCard(tp,c511000610.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil):GetFirst()
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if Duel.GetFlagEffect(tp,62765383)>0 then
			if fc then Duel.Destroy(fc,REASON_RULE) end
			of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		else
			Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		end
	end
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.Hint(HINT_CARD,0,tc:GetCode())
	tc:CreateEffectRelation(te)
	if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
		tc:CancelToGrave(false)
	end
	if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local etc=g:GetFirst()
		while etc do
			etc:CreateEffectRelation(te)
			etc=g:GetNext()
		end
	end
	if op then op(te,tp,eg,ep,ev,re,r,rp) end
	tc:ReleaseEffectRelation(te)
	if etc then	
		etc=g:GetFirst()
		while etc do
			etc:ReleaseEffectRelation(te)
			etc=g:GetNext()
		end
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511000610.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=sg:GetFirst()
	if tc then
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
