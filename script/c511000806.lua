--Hellfire Boatwatcher, Ghost Charon
function c511000806.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c511000806.syntg)
	e1:SetValue(1)
	e1:SetOperation(c511000806.synop)
	c:RegisterEffect(e1)
end
function c511000806.synfilter1(c,syncard,tuner,f)
	return c:IsFaceup() and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard,tuner) and (f==nil or f(c))
end
function c511000806.synfilter2(c,syncard,tuner,f)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard,tuner) and (f==nil or f(c))
end
function c511000806.syntg(e,syncard,f,minc,maxc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	if lv<=0 then return false end
	local g=Duel.GetMatchingGroup(c511000806.synfilter1,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
	local exg=Duel.GetMatchingGroup(c511000806.synfilter2,syncard:GetControler(),LOCATION_GRAVE,0,c,syncard,c,f)
	g:Merge(exg)
	return g:CheckWithSumEqual(Card.GetSynchroLevel,lv,1,1,syncard)
end
function c511000806.synop(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc,maxc)
	local c=e:GetHandler()
	local lv=syncard:GetLevel()-c:GetLevel()
	local g=Duel.GetMatchingGroup(c511000806.synfilter1,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
	local exg=Duel.GetMatchingGroup(c511000806.synfilter2,syncard:GetControler(),LOCATION_GRAVE,0,c,syncard,c,f)
	g:Merge(exg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local sg=g:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv,1,1,syncard)
	Duel.SetSynchroMaterial(sg)
end
