--Silent Magician LV0
function c511001141.initial_effect(c)
	--Update ATK and Level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c511001141.rcon)
	e1:SetOperation(c511001141.rop)
	c:RegisterEffect(e1)
	--change name
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetValue(c511001141.val)
	c:RegisterEffect(e2)
end
function c511001141.rcon(e,tp,eg,ep,ev,re,r,rp)
	local ect=e:GetHandler():GetEffectCount(511001141)
	return ep~=tp and 15-ect>0
end
function c511001141.rop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=eg:FilterCount(Card.IsControler,nil,1-tp)
	local ect=c:GetEffectCount(511001141)
	if ect>=15 then return end
	if 15-ect<ct then
		ct=15-ct
	end
	if 15-ect<=0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(ct*500)
	c:RegisterEffect(e1)
	for i=1,ct do
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(511001141)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
	Duel.BreakEffect()
end
function c511001141.val(e,c)
	local ect=e:GetHandler():GetEffectCount(511001141)
	if ect>0 and ect<4 then
		return 511001830+ect
	elseif ect==4 then
		return 73665146
	elseif ect>4 and ect<8 then
		return 511001829+ect
	elseif ect==8 then
		return 72443568
	elseif ect>8 then
		return 511001828+ect
	else
		return 511001141
	end
end
