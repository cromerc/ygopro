--Warrior Defense
--scripted by:urielkama
function c511004112.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_DESTROYED)
e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
e1:SetCondition(c511004112.condition)
e1:SetTarget(c511004112.target)
e1:SetOperation(c511004112.activate)
c:RegisterEffect(e1)
end
function c511004112.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp or c:GetPreviousControler()~=tp
end
function c511004112.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511004112.cfilter,1,nil,tp)
end
function c511004112.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c511004112.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsControler(1-tp) and c511004112.filter(chkc) end
if chk==0 then return Duel.IsExistingTarget(c511004112.filter,tp,0,LOCATION_MZONE,1,nil) end
local g=Duel.SelectTarget(tp,c511004112.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511004112.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
local dtg=eg:GetFirst()
local atk=dtg:GetAttack()
if atk<0 then atk=0 return end
if tc:IsFacedown() then return end
if tc and tc:IsRelateToEffect(e) then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-atk)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
end