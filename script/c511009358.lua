--Step on Shadow
function c511009358.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009358.target)
	e1:SetOperation(c511009358.activate)
	c:RegisterEffect(e1)
end

function c511009358.ctlfilter(c,e,tp,lv)
	return c:IsLevelBelow(lv-1) and c:IsControlerCanBeChanged()
end
function c511009358.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x9f) and Duel.IsExistingMatchingCard(c511009358.ctlfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,c:GetLevel())
end
function c511009358.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511009358.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511009358.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511009358.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511009358.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c511009358.ctlfilter,tp,LOCATION_MZONE,0,ft,ft,nil,e,tp,tc:GetLevel())
	local tg=g:GetFirst()
	while tg do
		Duel.GetControl(tg,1-tp,PHASE_END,1)
		tc=g:GetNext()
	end
end
