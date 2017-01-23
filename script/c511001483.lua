--Sky of Endless Night
function c511001483.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511001483.reptg)
	e2:SetValue(c511001483.repval)
	e2:SetOperation(c511001483.repop)
	c:RegisterEffect(e2)
end
function c511001483.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
end
function c511001483.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001483.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511001483.repfilter,nil,tp)
	if chk==0 then return eg:IsExists(c511001483.repfilter,1,nil,tp) end
	e:SetLabelObject(g)
	return Duel.IsExistingMatchingCard(c511001483.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c511001483.repval(e,c)
	return c511001483.repfilter(c,e:GetHandlerPlayer())
end
function c511001483.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local xyz=Duel.SelectMatchingCard(tp,c511001483.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		if xyz:GetCount()>0 then
			Duel.HintSelection(xyz)
			Duel.Overlay(xyz:GetFirst(),g)
		end
	end
end
