--クレスト・バーン
function c100000371.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c100000371.condition)
	e1:SetOperation(c100000371.activate)
	c:RegisterEffect(e1)
end
function c100000371.cfilter(c,e,tp)
	local ct=c:GetCounter(0x95)
	if c:IsCode(100000370) then
	e:SetLabel(ct) end
	return c:IsPreviousPosition(POS_FACEUP) and c:IsReason(REASON_DESTROY) and c:GetControler()==tp
	 and c:GetCounter(0x95)>0 and c:IsLocation(LOCATION_GRAVE) and c:IsCode(100000370)
end
function c100000371.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)	
	return eg:IsExists(c100000371.cfilter,1,nil,e,tp)
	 and tc~=nil and tc:IsFaceup() and tc:GetCode()==111215001
end
function c100000371.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if tc~=nil then return end
	local c=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if c==0 then return end
	local ct=e:GetLabel()
	if c<=ct then ct=c end
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetOperation(c100000371.disop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	tc:RegisterFlagEffect(tp,111215001,RESET_EVENT+0x1fe0000,0,ct)
end
function c100000371.disop(e,tp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if tc~=nil then return end
	local c=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if c==0 then return end
	local ct=e:GetLabel()
	if c<=ct then ct=c end
	local dis1=Duel.SelectDisableField(tp,ct,LOCATION_MZONE,0,0)
	return dis1
end

