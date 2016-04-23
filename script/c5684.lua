--トゥーン・キングダム
function c5684.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c5684.target)
	e1:SetOperation(c5684.activate)
	c:RegisterEffect(e1)
	--change name
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetValue(15259703)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c5684.tgtg)
	e3:SetValue(c5684.tgval)
	c:RegisterEffect(e3)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c5684.destg)
	e4:SetValue(c5684.desval)
	e4:SetOperation(c5684.desop)
	c:RegisterEffect(e4)
end
function c5684.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetDecktopGroup(tp,3):IsExists(Card.IsAbleToRemove,3,nil) end
end
function c5684.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end
function c5684.tgtg(e,c)
	return c:IsType(TYPE_TOON)
end
function c5684.tgval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c5684.dfilter(c,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_ONFIELD)
		and c:IsType(TYPE_TOON) and c:IsControler(tp) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c5684.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=eg:FilterCount(c5684.dfilter,nil,tp)
		e:SetLabel(count)
		return count>0 and Duel.GetDecktopGroup(tp,count):IsExists(Card.IsAbleToRemove,count,nil)
	end
	return Duel.SelectYesNo(tp,aux.Stringid(5684,0))
end
function c5684.desval(e,c)
	return c:IsFaceup() and c:IsLocation(LOCATION_ONFIELD)
		and c:IsType(TYPE_TOON) and c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c5684.desop(e,tp,eg,ep,ev,re,r,rp)
	local count=e:GetLabel()
	local g=Duel.GetDecktopGroup(tp,count)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end
