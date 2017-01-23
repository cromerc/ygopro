--Gadget Box
function c511001301.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001301.tg)
	c:RegisterEffect(e1)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001301,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetLabel(3)
	e2:SetCountLimit(1)
	e2:SetTarget(c511001301.target)
	e2:SetOperation(c511001301.operation)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c511001301.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetLabelObject():SetLabel(3)
end
function c511001301.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001302,0,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001301.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ct=e:GetLabel()
	ct=ct-1
	e:SetLabel(ct)
	if ct<=0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001302,0,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,511001302)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1)
end
