--Ｓｐ－奈落との契約
function c100101003.initial_effect(c)
	aux.AddRitualProcEqual(c,c100101003.ritual_filter)
end
function c100101003.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_DARK) 
	 and Duel.GetFieldCard(Duel.GetTurnPlayer(),LOCATION_SZONE,5):GetCounter(0x91)>1
end
