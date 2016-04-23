--新生代化石マシン　スカルバギー
function c100000620.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c100000620.ffilter1,c100000620.ffilter2,1,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
end
function c100000620.ffilter1(c)
	return c:IsRace(RACE_ROCK) and c:GetOwner()==Duel.GetTurnPlayer()
end
function c100000620.ffilter2(c)
	return c:GetOwner()~=Duel.GetTurnPlayer()
end
