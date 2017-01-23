--Jumbo Drill (anime)
function c511009061.initial_effect(c)
	--to defence
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009061.poscon)
	e1:SetOperation(c511009061.posop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c511009061.val)
	c:RegisterEffect(e3)
end
-- Heavy Industry Collection
c511009061.collection={
[42851643]=true;[29515122]=true;[13647631]=true;[511002686]=true;[511002687]=true;
}
function c511009061.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c511009061.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_COPY_INHERIT)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,3)
	c:RegisterEffect(e1)
end
function c511009061.val(e,c)
	return Duel.GetMatchingGroupCount(c511009061.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
function c511009061.filter(c)
	return c:IsFaceup() and c511009061.collection[c:GetCode()]
end