--Lefty Driver
function c511000741.initial_effect(c)
	--synchro level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_LEVEL)
	e2:SetCondition(c511000741.scon)
	e2:SetValue(c511000741.slevel)
	c:RegisterEffect(e2)
end
function c511000741.scon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL
end
function c511000741.slevel(e,c)
	local lv=e:GetHandler():GetLevel()
	return 3*65536+lv
end
