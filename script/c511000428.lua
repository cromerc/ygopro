--Limit Tribute
function c511000428.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
    --Restrict Release
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
    e2:SetCondition(c511000428.conA)
	c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetTargetRange(0,1)
    e3:SetCondition(c511000428.conB)
    c:RegisterEffect(e3)
    --Responding
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetRange(LOCATION_SZONE)
    e4:SetCondition(c511000428.cond)
	e4:SetOperation(c511000428.relimit)
	c:RegisterEffect(e4)
end
function c511000428.conA(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(511000428)~=0
end
function c511000428.conB(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(511000428)~=0
end
function c511000428.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReason(REASON_RELEASE)
end
function c511000428.cond(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000428.filter,1,nil,tp)
end
function c511000428.relimit(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp then
        e:GetHandler():RegisterFlagEffect(511000428,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
    else
        e:GetHandler():RegisterFlagEffect(511000428,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
    end
end