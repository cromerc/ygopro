--Speed World Neo
function c95000102.initial_effect(c)
	--Activate	/  Speed World 2
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetOperation(c95000102.op)
	c:RegisterEffect(e1)
	--untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(aux.tgval)
	c:RegisterEffect(e2)
	--unaffectable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	c:RegisterEffect(e5)
	--cannot set
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_SSET)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTargetRange(1,1)
	e7:SetTarget(c95000102.aclimit2)
	c:RegisterEffect(e7)		
	--cannot activate
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_CANNOT_ACTIVATE)
	e8:SetRange(LOCATION_SZONE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetTargetRange(1,1)
	e8:SetValue(c95000102.efilter)
	c:RegisterEffect(e8)
end
function c95000102.efilter(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c95000102.filter(c)
	return c:GetCode()~=95000102
end

function c95000102.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)if Duel.GetMatchingGroup(c95000102.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()>39
	 and tc==nil then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if tc2==nil then
			local token=Duel.CreateToken(tp,95000102,nil,nil,nil,nil,nil,nil)		
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_FIELD)
			token:RegisterEffect(e1)
			Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SpecialSummonComplete()
		end
	else
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end