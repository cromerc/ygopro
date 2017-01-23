--Number 5: Doom Chimera Dragon (Anime)
function c511010005.initial_effect(c)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010005.indes)
	c:RegisterEffect(e6)
end
c511010005.xyz_number=5
function c511010005.indes(e,c)
return not c:IsSetCard(0x48)
end