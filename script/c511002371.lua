--火車
function c511002371.initial_effect(c)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(52512994,0))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c511002371.tdtg)
	e3:SetOperation(c511002371.tdop)
	c:RegisterEffect(e3)
end
function c511002371.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c511002371.rfilter(c)
	return c:IsLocation(LOCATION_DECK+LOCATION_EXTRA) and c:IsRace(0x10000000) and bit.band(c:GetPreviousPosition(),POS_FACEUP)~=0
end
function c511002371.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	local c=e:GetHandler()
	local rt=Duel.GetOperatedGroup():FilterCount(c511002371.rfilter,nil)
	if rt>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(rt*1000)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
