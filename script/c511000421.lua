--Goddess Urd's Verdict
function c511000421.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000421,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511000421.target)
	e2:SetOperation(c511000421.operation)
	c:RegisterEffect(e2)
end
function c511000421.filter(c)
return c:IsFacedown() and c:IsAbleToRemove()
end
function c511000421.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()~=tp and chkc:IsLocation(LOCATION_ONFIELD) and c511000421.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000421.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,c511000421.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,0)
	local ac=Duel.AnnounceCard(tp)
	e:SetLabel(ac)
end
function c511000421.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.ConfirmCards(tp,tc)
	if tc:GetCode()==e:GetLabel() and  tc:IsAbleToRemove() then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end

	
