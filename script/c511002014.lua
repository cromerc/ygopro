--Supreme Thunder Star Raijin
function c511002014.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511002014.ffilter1,c511002014.ffilter2,true)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
c511002014.earth_collection={
	[42685062]=true;[76052811]=true;[71564150]=true;[77827521]=true;[75375465]=true;
	[70595331]=true;[67987302]=true;[94773007]=true;[45042329]=true;
}
c511002014.sky_collection={
	[10000020]=true;[79575620]=true;[32559361]=true;[77998771]=true;[15914410]=true;
	[49771608]=true;[61777313]=true;[40844552]=true;[76348260]=true;[2356994]=true;
	[53334641]=true;[3629090]=true;[77235086]=true;[16972957]=true;[42216237]=true;
	[42418084]=true;[59509952]=true;[18378582]=true;[81146288]=true;[85399281]=true;
	[58601383]=true;[86327225]=true;[41589166]=true;[37910722]=true;[12171659]=true;
	[75326861]=true;[2519690]=true;[96570609]=true;[95457011]=true;[74841885]=true;
	[11458071]=true;[48453776]=true;[90122655]=true;[69865139]=true;[32995007]=true;
	[1992816]=true;[80764541]=true;[87390067]=true;[3072808]=true;[49674183]=true;
	[42431843]=true;[29146185]=true;[69992868]=true;[96470883]=true;[10028593]=true;
}
function c511002014.ffilter1(c)
	return c:IsFusionSetCard(0x408) or c:IsFusionSetCard(0x21f) or c:IsFusionSetCard(0x21) or c511002014.earth_collection[c:GetFusionCode()])
end
function c511002014.ffilter2(c)
	return c:IsFusionSetCard(0x407) or c:IsFusionSetCard(0xef) or c511002014.sky_collection[c:GetFusionCode()])
end
