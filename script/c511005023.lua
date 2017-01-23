--Bonds of Hope
--  By Shad3
--fixed by MLD
function c511005023.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCondition(c511005023.condition)
	e1:SetTarget(c511005023.target)
	e1:SetOperation(c511005023.activate)
	c:RegisterEffect(e1)
end
function c511005023.cfilter(c,tp)
	return c:IsType(TYPE_XYZ) and c:IsControler(tp)
end
function c511005023.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511005023.cfilter,1,nil,tp)
end
function c511005023.filter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511005023.filter2(c)
	return c:IsType(TYPE_XYZ) and c:IsFaceup() and c:GetOverlayCount()~=0
end
function c511005023.filter3(c)
	return c:IsType(TYPE_XYZ) and c:IsFaceup()
end
function c511005023.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511005023.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingTarget(c511005023.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) 
		and Duel.IsExistingMatchingCard(c511005023.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511005023.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511005023.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)<=0 then return end
	local xc
	local og=Group.CreateGroup()
	if c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
		local xg=Duel.SelectMatchingCard(tp,c511005023.filter2,tp,LOCATION_MZONE,0,1,1,nil,TYPE_XYZ)
		if xg:GetCount()>0 then
			Duel.HintSelection(xg)
			xc=xg:GetFirst()
			og=xc:GetOverlayGroup()
			c:CancelToGrave()
			og:AddCard(c)
		end
	end
	if og:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local ng=Duel.SelectMatchingCard(tp,c511005023.filter3,tp,LOCATION_MZONE,0,1,1,xc)
		Duel.HintSelection(ng)
		local nc=ng:GetFirst()
		Duel.Overlay(nc,og)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c511005023.desop)
	e1:SetLabelObject(tc)
	Duel.RegisterEffect(e1,tp)
end
function c511005023.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsOnField() then Duel.Destroy(tc,REASON_EFFECT) end
end
