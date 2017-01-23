--Spell Spice Cinnamon
function c511001223.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001223.target)
	e1:SetOperation(c511001223.activate)
	c:RegisterEffect(e1)
end
function c511001223.filter1(c)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_ATTACK)
end
function c511001223.filter2(c)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_DEFENSE)
end
function c511001223.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511001223.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c511001223.filter2,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g1=Duel.SelectTarget(tp,c511001223.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g2=Duel.SelectTarget(tp,c511001223.filter2,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g2,1,0,0)
end
function c511001223.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc2==tc1 then tc2=g:GetNext() end
	if tc1:IsRelateToEffect(e) and tc1:IsFaceup() and tc2:IsRelateToEffect(e) then 
		Duel.ChangePosition(tc1,POS_FACEUP_DEFENSE)
		Duel.ChangePosition(tc2,POS_FACEUP_ATTACK)
	end
end
