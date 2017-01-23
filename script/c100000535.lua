--Ragnarok
--Fixed by Edo9300
function c100000535.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000535,4))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000535.target)
	e1:SetOperation(c100000535.operation)
	c:RegisterEffect(e1)
end
c100000535.dark_magician_list=true
function c100000535.cfilter(c)
	local code=c:GetCode()
	return c:IsFaceup() and (code==92377303 or code==46986414 or code==38033121 or code==30208479)
end
function c100000535.dfilter(c)
	return c:IsDestructable()
end
function c100000535.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c100000535.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil) and Duel.IsExistingMatchingCard(c100000535.dfilter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c100000535.dfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100000535.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,0x13,0,nil,TYPE_MONSTER)
	if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)>0 then
		local dg=Duel.GetMatchingGroup(c100000535.dfilter,tp,0,LOCATION_MZONE,nil)
		if dg:GetCount()>0 then
			Duel.SendtoGrave(dg,REASON_DESTROY+REASON_EFFECT)
		end
	end
end
