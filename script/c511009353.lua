--Speedroid Passing Rider (Manga)
function c511009353.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37798171,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c511009353.ntcon)
	c:RegisterEffect(e1)
	-- must be attacked
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MUST_BE_ATTACKED)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c511009353.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)==0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
end
