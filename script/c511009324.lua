--Parasite Plant
--fixed by MLD
function c511009324.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP+CATEGORY_FUSION_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c511009324.target)
	e1:SetOperation(c511009324.operation)
	c:RegisterEffect(e1)
	--eq
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL+CATEGORY_EQUIP)
	e4:SetDescription(aux.Stringid(11493868,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511009324.eqtg)
	e4:SetOperation(c511009324.eqop)
	c:RegisterEffect(e4)
end
function c511009324.eqfilter(c,g,tp)
	return c:IsFaceup() and c:IsCode(6205579) and c:IsControler(tp) and c:IsAbleToGrave() and g:IsExists(c511009324.eqfilter2,1,c)
end
function c511009324.eqfilter2(c)
	return c:IsFaceup() and c:IsCode(6205579) and c:IsAbleToGrave()
end
function c511009324.filter(c,tp)
	local g=c:GetEquipGroup()
	if c:IsControler(1-tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end 
	return g:IsExists(c511009324.eqfilter,1,nil,g,tp) and c:IsAbleToGrave() and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
end
function c511009324.spfilter(c,e,tp)
	return c:IsCode(511009344) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
end
function c511009324.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009324.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009324.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) 
		and Duel.IsExistingMatchingCard(c511009324.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectTarget(tp,c511009324.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	local g2=g1:GetFirst():GetEquipGroup()
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g1,g1:GetCount(),0,0)
end
function c511009324.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=tc:GetEquipGroup()
		if not c511009324.filter(tc,tp) then return end
		g:AddCard(tc)
		if Duel.SendtoGrave(g,REASON_EFFECT)>2 and tc:IsLocation(LOCATION_GRAVE) and g:IsExists(Card.IsLocation,2,tc,LOCATION_GRAVE) then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sc=Duel.SelectMatchingCard(tp,c511009324.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
			if sc and Duel.SpecialSummonStep(sc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
				e1:SetRange(LOCATION_MZONE)
				e1:SetCode(EFFECT_IMMUNE_EFFECT)
				e1:SetValue(c511009324.efilter)
				e1:SetOwnerPlayer(tp)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1,true)
				Duel.SpecialSummonComplete()
				local eqg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,6205579)
				if eqg:GetCount()>Duel.GetLocationCount(tp,LOCATION_SZONE) then return end
				local eqc=eqg:GetFirst()
				while eqc do
					if Duel.Equip(tp,eqc,sc,true) then
						local e1=Effect.CreateEffect(c)
						e1:SetType(EFFECT_TYPE_SINGLE)
						e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
						e1:SetCode(EFFECT_EQUIP_LIMIT)
						e1:SetReset(RESET_EVENT+0x1fe0000)
						e1:SetValue(c511009324.eqlimit)
						e1:SetLabelObject(sc)
						eqc:RegisterEffect(e1)
					end
					eqc=eqg:GetNext()
				end
				Duel.EquipComplete()
			end
		end
	end
end
function c511009324.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_MONSTER)
end
function c511009324.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c511009324.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetOwner()~=e:GetOwner()
		and te:IsActiveType(TYPE_MONSTER)
end
function c511009324.ctfilter(c,tp)
	return c:IsFaceup() and c:IsCode(511009344) and (c:IsControler(tp) or c:IsControlerCanBeChanged())
end
function c511009324.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009324.ctfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingTarget(c511009324.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,6205579) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511009324.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK)
end
function c511009324.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
		local ec=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,6205579):GetFirst()
		if not ec then return end
		if Duel.Equip(tp,ec,tc,true) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511009324.eqlimit)
			e1:SetLabelObject(tc)
			ec:RegisterEffect(e1)
			if tc:IsControler(1-tp) then
				Duel.GetControl(tc,tp)
			end
		end
	end
end
