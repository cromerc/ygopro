--Earthbound Prisoner Ground Keeper
function c511002987.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002987.indtg)
	e1:SetValue(c511002987.indval)
	c:RegisterEffect(e1)
end
function c511002987.filter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() 
		and (c:IsSetCard(0x21f) or c:IsSetCard(0x21) or c:IsCode(67105242) or c:IsCode(67987302))
end
function c511002987.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511002987.filter,1,nil,tp) end
	return true
end
function c511002987.indval(e,c)
	return c511002987.filter(c,e:GetHandlerPlayer())
end
