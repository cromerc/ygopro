--ビッグバン・パニック
function c100000278.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000278.target)
	e1:SetOperation(c100000278.activate)
	c:RegisterEffect(e1)
end
function c100000278.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c100000278.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c100000278.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c100000278.filter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_SZONE,1,nil)
	end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectTarget(tp,c100000278.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,c100000278.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c100000278.activate(e,tp,eg,ep,ev,re,r,rp)
	local gc=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local ac1=e:GetLabelObject()
	local ac2=gc:GetFirst()
	local tc1=nil
	local tc2=nil
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_SZONE,nil)
	if ac1==ac2 then ac2=gc:GetNext() end
	if ac2:IsControler(tp) then tc1=ac2
	tc2=ac1	else tc1=ac1
	tc2=ac2	end
	if tc2 and tc2:IsRelateToEffect(e) then
		Duel.Overlay(tc2,g)
		Duel.BreakEffect()
		if tc1:GetControler()~=tc2:GetControler() and tc1:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(g:GetCount()*800)
			tc1:RegisterEffect(e1)
		end			
	end
end
