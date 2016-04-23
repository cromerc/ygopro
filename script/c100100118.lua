--Ｓｐ－ダッシュ・ピルファー
function c100100118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100118.con)
	e1:SetTarget(c100100118.target)
	e1:SetOperation(c100100118.activate)
	c:RegisterEffect(e1)
end
function c100100118.con(e,tp,eg,ep,ev,re,r,rp)
	local td=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return td:GetCounter(0x91)>3
end
function c100100118.filter(c)
	return c:IsControlerCanBeChanged() and c:IsPosition(POS_FACEUP_DEFENCE)
end
function c100100118.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100100118.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100100118.filter,tp,0,LOCATION_MZONE,1,nil) end
	return true
end
function c100100118.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c100100118.filter,tp,0,LOCATION_MZONE,nil)		
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local tdg=dg:Select(tp,1,1,nil)
	local tc=tdg:GetFirst()
	if tc and not Duel.GetControl(tc,tp,PHASE_END,1) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
