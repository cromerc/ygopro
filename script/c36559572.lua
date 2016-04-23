--Spider Web
function c36559572.initial_effect(c)
    local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c36559572.target)
	e1:SetOperation(c36559572.operation)
	c:RegisterEffect(e1)
	if not c36559572.global_check then
		c36559572.global_check=true
		local ge=Effect.CreateEffect(c)
		ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge:SetCode(EVENT_TO_GRAVE)
		ge:SetOperation(c36559572.op)
		Duel.RegisterEffect(ge,0)
		end
		end
function c36559572.filter(c)
    local tid=Duel.GetTurnCount()
	return c:IsAbleToHand() and c:GetFlagEffect(36559572)>0 and c:GetTurnID()~=tid 
	end

function c36559572.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==tp and c36559572.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c36559572.filter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c36559572.filter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c36559572.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c36559572.op(e,tp,eg,ep,ev,re,r,rp)
local tc=eg:GetFirst()
while tc do
if tc:IsLocation(LOCATION_GRAVE) then
tc:RegisterFlagEffect(36559572,RESET_PHASE+PHASE_END,0,2,1)
end
tc=eg:GetNext()
end
end
