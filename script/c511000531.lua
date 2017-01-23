-- DNA Erasure Magic
-- scripted by: UnknownGuest
function c511000531.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000531.target)
	c:RegisterEffect(e1)
	-- remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511000531.rmtarget)
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c511000531.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,563)
	local rc=Duel.AnnounceRace(tp,1,0xffffff)
	e:GetLabelObject():SetLabel(rc)
	e:GetHandler():SetHint(CHINT_RACE,rc)
end
function c511000531.rmtarget(e,c)
	local race=e:GetLabel()
	return c:IsRace(race) and not c:IsLocation(0x80) and not c:IsType(TYPE_SPELL+TYPE_TRAP)
end
