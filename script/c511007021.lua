--coded by Lyris
--fix by MLD
--Cursed Ivy
function c511007021.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511007021.target)
	e1:SetOperation(c511007021.operation)
	c:RegisterEffect(e1)
	--When this card is removed from the field, destroy that monster. [Premature Burial]
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c511007021.desop)
	c:RegisterEffect(e2)
	--Special Summon 2 "Ivy Tokens" (Plant-Type/EARTH/Level 1/ATK 0/DEF 0) to your opponent's side of the field in Defense Position. [Wall of Ivy]
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c511007021.spcon)
	e3:SetTarget(c511007021.sptg)
	e3:SetOperation(c511007021.spop)
	c:RegisterEffect(e3)
end
function c511007021.spfilter(c,e,tp)
	return c:IsCode(30069398) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511007021.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511007021.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511007021.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511007021.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511007021.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511007021.operation(e,tp,eg,ep,ev,re,r,rp)
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
		e1:SetValue(c511007021.eqlimit)
		c:RegisterEffect(e1)
	end
end
function c511007021.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511007021.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511007021.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511007021.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=1 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,30069399,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,30069399)
		if Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_DESTROYED)
			e1:SetLabelObject(token)
			e1:SetCondition(c511007021.damcon)
			e1:SetOperation(c511007021.damop)
			Duel.RegisterEffect(e1,tp)
		end
	end
	Duel.SpecialSummonComplete()
end
function c511007021.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tok=e:GetLabelObject()
	if eg:IsContains(tok) then
		return true
	else
		if not tok:IsLocation(LOCATION_MZONE) then e:Reset() end
		return false
	end
end
function c511007021.damop(e,tp,eg,ep,ev,re,r,rp)
	local tok=e:GetLabelObject()
	Duel.Damage(tok:GetPreviousControler(),300,REASON_EFFECT)
end
