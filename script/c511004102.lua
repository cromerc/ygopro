--Xyz Stun
--scripted by:urielkama
function c511004102.initial_effect(c)
--disable
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511004102,0))
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCategory(CATEGORY_NEGATE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c511004102.target)
e1:SetOperation(c511004102.activate)
c:RegisterEffect(e1)
end
function c511004102.tgfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsFaceup()
end
function c511004102.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004102.tgfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
   	local g=Duel.SelectTarget(tp,c511004102.tgfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
   	Duel.SetOperationInfo(0,CATEGORY_NEGATE,g,1,0,0)
end
function c511004102.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc:IsRelateToEffect(e) then
local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
	end
end