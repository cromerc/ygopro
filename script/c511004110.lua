--Water Barrier
--scripted by:urielkama
function c511004110.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c511004110.target)
e1:SetOperation(c511004110.activate)
c:RegisterEffect(e1)
end
function c511004110.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511004110.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingTarget(c511004110.filter,tp,LOCATION_MZONE,0,1,nil) end
local g=Duel.SelectTarget(tp,c511004110.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511004110.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc:IsFacedown() then return end
if tc and tc:IsRelateToEffect(e) then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(aux.imval1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	end
end