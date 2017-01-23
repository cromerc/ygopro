--Guivre
function c511002176.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74440055,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetTarget(c511002176.target)
	e1:SetOperation(c511002176.operation)
	c:RegisterEffect(e1)
end
function c511002176.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c511002176.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511002177,0,0x4011,0,0,1,RACE_DRAGON,0,POS_FACEUP,tp) then
		local token=Duel.CreateToken(tp,511002177)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
