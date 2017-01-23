--Overlay Rebirth
function c511001765.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001765.target)
	e1:SetOperation(c511001765.activate)
	c:RegisterEffect(e1)
end
function c511001765.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001765.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511001765.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,2,nil,TYPE_MONSTER) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001765.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,0,2,2,nil,TYPE_MONSTER)
end
function c511001765.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()<3 then return end
	local tc=tg:Filter(Card.IsLocation,nil,LOCATION_MZONE):GetFirst()
	local mat=tg:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
	if tc and tc:IsRelateToEffect(e) and tc:IsType(TYPE_XYZ) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) 
		and mat:GetCount()==2 then
		Duel.Overlay(tc,mat)
	end
end
