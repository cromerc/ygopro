--虚无械アイン
function c100000012.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c100000012.target1)
	e1:SetOperation(c100000012.operation)
	c:RegisterEffect(e1)
	--to Grave
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetTarget(c100000012.target2)
	e2:SetOperation(c100000012.operation)
	c:RegisterEffect(e2)
end
function c100000012.rfilter(c)
	return c:IsSetCard(0x4a) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c100000012.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c100000012.rfilter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c100000012.rfilter,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(100000012,0)) then
	local cg=Duel.SelectTarget(tp,c100000012.rfilter,tp,LOCATION_HAND,0,1,1,nil)
	if cg:GetCount()==0 then return end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SendtoGrave(cg,REASON_EFFECT+REASON_DISCARD)
	e:GetHandler():RegisterFlagEffect(100000012,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	else e:SetProperty(0) end
end
function c100000012.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c100000012.rfilter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(100000012)==0
		and Duel.IsExistingTarget(c100000012.rfilter,tp,LOCATION_HAND,0,1,nil) end
	local cg=Duel.SelectTarget(tp,c100000012.rfilter,tp,LOCATION_HAND,0,1,1,nil)
	if cg:GetCount()==0 then return end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SendtoGrave(cg,REASON_EFFECT+REASON_DISCARD)
	e:GetHandler():RegisterFlagEffect(100000012,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000012.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
