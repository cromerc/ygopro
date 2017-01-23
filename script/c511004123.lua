--Utopia Rising
--scripted by:urielkama
function c511004123.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511004123.target)
	e1:SetOperation(c511004123.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511004123.desop)
	c:RegisterEffect(e2)
end
function c511004123.spfilter(c,e,tp)
	return c:IsCode(84013237) or c:IsCode(511002599) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511004123.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511004123.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511004123.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511004123.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511004123.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511004123.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e0=Effect.CreateEffect(tc)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetCode(EFFECT_EQUIP_LIMIT)
		e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e0:SetReset(RESET_EVENT+0x1fe0000)
		e0:SetValue(c511004123.eqlimit)
		c:RegisterEffect(e0)
		--copy	
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetRange(LOCATION_MZONE)	
		e1:SetOperation(c511004123.operation2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c511004123.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511004123.filter(c)
	return c:IsType(TYPE_XYZ)
end
function c511004123.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local wg=Duel.GetMatchingGroup(c511004123.filter,c:GetControler(),LOCATION_MZONE,0,nil)
	local wbc=wg:GetFirst()
	while wbc do
		local code=wbc:GetOriginalCode()
		if c:IsFaceup() and c:GetFlagEffect(code)==0 and code:IsStatus(STATUS_ACTIVATED) then
			c:CopyEffect(code,RESET_EVENT+0x1ff0000+RESET_PHASE+RESET_END,1)
			c:RegisterFlagEffect(code,RESET_EVENT+0x1ff0000+RESET_PHASE+RESET_END,0,1)
		end
		wbc=wg:GetNext()
	end		
end