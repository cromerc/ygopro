--Fusion Buster
function c511000332.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000332.target)
	e1:SetOperation(c511000332.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(300)
	c:RegisterEffect(e3)
	--Activate
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1)
	e4:SetTarget(c511000332.rettg)
	e4:SetOperation(c511000332.retop)
	c:RegisterEffect(e4)
	--Activate
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DISABLE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511000332.polycon)
	e5:SetCost(c511000332.polycost)
	e5:SetTarget(c511000332.polytg)
	e5:SetOperation(c511000332.polyop)
	c:RegisterEffect(e5)
end
function c511000332.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000332.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000332.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end
function c511000332.rettg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000332.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000332.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511000332.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c511000332.mgfilter(c,e,tp,fusc)
	return not c:IsControler(1-tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,1-tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000332.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)==0 or bit.band(sumtype,SUMMON_TYPE_FUSION)~=SUMMON_TYPE_FUSION or mg:GetCount()==0
		or mg:GetCount()>Duel.GetLocationCount(tp,LOCATION_MZONE)
		or mg:IsExists(c511000332.mgfilter,1,nil,e,tp,tc) then
		sumable=false
	end
	if sumable then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,1-tp,1-tp,false,false,POS_FACEUP)
	end
end
function c511000332.polycon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(24094653) and Duel.IsChainDisablable(ev)
end
function c511000332.polycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511000332.polytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511000332.polyop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
