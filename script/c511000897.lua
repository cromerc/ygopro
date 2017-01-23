--Burning Rebirth
function c511000897.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c511000897.cost)
	e1:SetTarget(c511000897.target)
	e1:SetOperation(c511000897.activate)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511000897.desop)
	c:RegisterEffect(e2)
	--sp summon tributed monster
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000897,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511000897.spcost)
	e3:SetTarget(c511000897.sptg)
	e3:SetOperation(c511000897.spop)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
end
function c511000897.cfilter(c)
	return c:IsFaceup() and c:GetLevel()>=8 and c:IsType(TYPE_SYNCHRO)
end
function c511000897.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000897.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511000897.cfilter,1,1,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	Duel.Release(g,REASON_COST)
end
function c511000897.spfilter(c,e,tp)
	return c:IsCode(70902743) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000897.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511000897.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c511000897.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000897.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000897.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)==0 then return end
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511000897.eqlimit)
		c:RegisterEffect(e1)
	end
end
function c511000897.eqlimit(e,c)
	return c:GetControler()==e:GetOwnerPlayer()
end
function c511000897.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511000897.spcfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsAbleToGraveAsCost()
end
function c511000897.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000897.spcfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c511000897.spcfilter,tp,LOCATION_HAND,0,1,1,nil)
	cg:AddCard(e:GetHandler())
	Duel.SendtoGrave(cg,REASON_COST)
end
function c511000897.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject():GetLabelObject():GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and tc:IsLocation(LOCATION_GRAVE) 
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and tc:IsType(TYPE_SYNCHRO) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,tp,LOCATION_GRAVE)
end
function c511000897.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject():GetLabelObject():GetFirst()
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
