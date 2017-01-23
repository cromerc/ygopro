--Tenma, the Rising Star Amidst the Heavens
function c511002012.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78651105,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c511002012.ntcon)
	c:RegisterEffect(e1)
end
--Earth Collection
c511002012.collection1={
[42685062]=true;[76052811]=true;[71564150]=true;
[77827521]=true;[75375465]=true;[70595331]=true;
[67987302]=true;[94773007]=true;[45042329]=true;	
}
function c511002012.cfilter(c)
	return c:IsFaceup() and ((c511002012.collection1[c:GetCode()] or c:IsSetCard(0x408) or c:IsSetCard(0x21) or c:IsSetCard(0x21f)))
end
function c511002012.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002012.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
