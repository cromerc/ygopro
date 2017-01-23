--Mask of Shine and Dark (DOR)
--Scripted by GameMaster (GM)
function c511005606.initial_effect(c)
	--gain 900 atk against warrior race
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c511005606.condtion)
	e1:SetValue(900)
	c:RegisterEffect(e1)
end
function c511005606.condtion(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) or not e:GetHandler():IsRelateToBattle() then return false end
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsRace(RACE_WARRIOR)
end

