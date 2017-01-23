--Xyz Move 
--scripted by:urielkama
function c511004104.initial_effect(c)
--change control and end battle phase
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511004104,0))
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCategory(CATEGORY_CONTROL)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetCondition(c511004104.condition)
e1:SetTarget(c511004104.target)
e1:SetOperation(c511004104.activate)
c:RegisterEffect(e1)
end
function c511004104.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,1,nil,TYPE_XYZ)
end
function c511004104.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsAbleToChangeControler() and chkc:IsType(TYPE_XYZ) end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_SKIP_BP) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511004104.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(tp) and tc:IsAbleToChangeControler() and not tc:IsImmuneToEffect(e) then
			Duel.GetControl(tc,1-tp)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_SKIP_BP)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(0,1)
			e1:SetReset(RESET_PHASE+PHASE_BATTLE)
			Duel.RegisterEffect(e1,tp)
	end
end