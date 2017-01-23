--サイレント・ソードマン LV0
function c511001137.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001137,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_REPEAT)
	e1:SetCondition(c511001137.atkcon)
	e1:SetOperation(c511001137.atkop)
	c:RegisterEffect(e1)
	--change name
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetValue(c511001137.val)
	c:RegisterEffect(e2)
end
c511001137.lvupcount=1
c511001137.lvup={511001846}
function c511001137.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ect=e:GetHandler():GetEffectCount(511001137)
	return tp==Duel.GetTurnPlayer() and 15-ect>0
end
function c511001137.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c:GetBaseAttack()+500)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(511001137)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	if e:GetHandler():GetEffectCount(511001137)==4 and Duel.SendtoGrave(c,REASON_EFFECT)>0 then
		local token=Duel.CreateToken(tp,511001846)
		Duel.MoveToField(token,tp,tp,LOCATION_MZONE,c:GetPreviousPosition(),true)
		token:SetStatus(STATUS_PROC_COMPLETE,true)
		token:SetStatus(STATUS_SPSUMMON_TURN,true)
	end
end
function c511001137.val(e,c)
	local ect=e:GetHandler():GetEffectCount(511001137)
	if ect>0 and ect<3 then
		return 511001843+ect
	elseif ect==3 then
		return 1995985
	elseif ect==4 then
		return 511001846
	elseif ect==5 then
		return 74388798
	elseif ect==6 then
		return 511001847
	elseif ect==7 then
		return 37267041
	elseif ect>7 then
		return 511001840+ect
	else
		return 511001137
	end
end
