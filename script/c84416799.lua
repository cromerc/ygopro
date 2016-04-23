--Silent Magician LV0
function c84416799.initial_effect(c)
	--Update ATK and Level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c84416799.rcon)
	e1:SetOperation(c84416799.rop)
	c:RegisterEffect(e1)
	end
function c84416799.rcon(e,tp,eg,ep,ev,re,r,rp)
return ep~=tp 
	end
function c84416799.rop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local ct=eg:GetCount()
--Attack Up
local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(ct*500)
	c:RegisterEffect(e1)
--Level Up 
local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetValue(ct)
	e2:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e2)
end
