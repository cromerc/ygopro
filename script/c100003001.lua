--機械天使の儀式
function c100003001.initial_effect(c)
	aux.AddRitualProcEqual(c,c100003001.ritual_filter)
end
function c100003001.ritual_filter(c)
	return c:IsSetCard(0x2093) and bit.band(c:GetType(),0x81)==0x81
end
