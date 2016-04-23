--機械天使の儀式
function c100003001.initial_effect(c)
	aux.AddRitualProcEqual(c,c100003001.ritual_filter)
end
function c100003001.ritual_filter(c)
	local code=c:GetCode()
	return code==100003002 or code==100003003 or code==100003004
end
