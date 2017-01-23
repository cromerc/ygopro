--Influence Dragon
function c511002689.initial_effect(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_CHECK)
	e2:SetValue(c511002689.syncheck)
	c:RegisterEffect(e2)
end
function c511002689.syncheck(e,c)
	if c:IsControler(e:GetHandlerPlayer()) then
		c:AssumeProperty(ASSUME_RACE,RACE_DRAGON)
	end
end
