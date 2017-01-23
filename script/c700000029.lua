--Scripted by Eerie Code
--Bloom Prima the Melodious Choir
--fixed by MLD
function c700000029.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,c700000029.mfilter1,aux.FilterBoolFunction(Card.IsFusionSetCard,0x9b),1,63,true)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c700000029.matcheck)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c700000029.mfilter1(c)
	local code=c:GetFusionCode()
	return code==14763299 or code==62895219
end
function c700000029.matcheck(e,c)
	local ct=c:GetMaterialCount()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ct*300)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
